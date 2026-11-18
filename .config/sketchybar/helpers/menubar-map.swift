// menubar-map: print, for each app named on the command line, which
// SketchyBar alias name ("Owner,Name(N)") its menu bar icon has right now.
//
//   menubar-map "CleanShot X" FluidVoice WireGuard WeatherMenu
//   -> one line per app:  APP<TAB>ALIAS<TAB>WIDTH   (ALIAS is "-" if not found)
//
// How: SketchyBar numbers menu items by listing every window on the menu bar
// layer (25) that has a name, sorted by x from right to left (src/alias.c,
// get_menu_item_list). We rebuild that list, then ask each app through the
// Accessibility API where its status item is and match by the icon's center.
// Needs Accessibility (to read other apps' status items) and Screen
// Recording (to see window names) for the process that runs it; run from a
// SketchyBar script it inherits SketchyBar's permissions.
import AppKit
import ApplicationServices

struct MenuWindow { let owner: String; let name: String; let x: CGFloat; let w: CGFloat }

func menuWindows() -> [MenuWindow] {
  guard let list = CGWindowListCopyWindowInfo([.optionAll], kCGNullWindowID) as? [[String: Any]]
  else { return [] }
  var out: [MenuWindow] = []
  for d in list {
    guard let owner = d[kCGWindowOwnerName as String] as? String,
          let name = d[kCGWindowName as String] as? String,
          let layer = d[kCGWindowLayer as String] as? Int, layer == 25,
          owner != "Window Server",
          let b = d[kCGWindowBounds as String] as? [String: Any],
          let x = b["X"] as? CGFloat, let w = b["Width"] as? CGFloat
    else { continue }
    out.append(MenuWindow(owner: owner, name: name, x: x, w: w))
  }
  // Same order as SketchyBar: highest x first. Stable for equal x.
  return out.enumerated().sorted { a, b in
    a.element.x != b.element.x ? a.element.x > b.element.x : a.offset < b.offset
  }.map { $0.element }
}

func statusItemFrames(pid: pid_t) -> [CGRect] {
  let app = AXUIElementCreateApplication(pid)
  var bar: CFTypeRef?
  guard AXUIElementCopyAttributeValue(app, "AXExtrasMenuBar" as CFString, &bar) == .success,
        let barEl = bar else { return [] }
  var kids: CFTypeRef?
  AXUIElementCopyAttributeValue(barEl as! AXUIElement, kAXChildrenAttribute as CFString, &kids)
  var frames: [CGRect] = []
  for k in (kids as? [AXUIElement]) ?? [] {
    var p: CFTypeRef?, s: CFTypeRef?
    var pt = CGPoint.zero, sz = CGSize.zero
    AXUIElementCopyAttributeValue(k, kAXPositionAttribute as CFString, &p)
    AXUIElementCopyAttributeValue(k, kAXSizeAttribute as CFString, &s)
    if let p { AXValueGetValue(p as! AXValue, .cgPoint, &pt) }
    if let s { AXValueGetValue(s as! AXValue, .cgSize, &sz) }
    if sz.width > 0 { frames.append(CGRect(origin: pt, size: sz)) }
  }
  return frames
}

let wanted = Array(CommandLine.arguments.dropFirst())
if wanted.isEmpty || wanted.first == "--list" {
  // Debug: print SketchyBar's numbering with positions.
  for (i, m) in menuWindows().enumerated() {
    print("\(m.owner),\(m.name)(\(i + 1))\tx=\(Int(m.x))\tw=\(Int(m.w))")
  }
  if !AXIsProcessTrusted() { FileHandle.standardError.write("menubar-map: no Accessibility permission\n".data(using: .utf8)!) }
  exit(0)
}
if !AXIsProcessTrusted() {
  FileHandle.standardError.write("menubar-map: no Accessibility permission\n".data(using: .utf8)!)
  exit(2)
}

if wanted.first == "--apps" {
  // Debug: every running app that reports a status item, with its frames.
  for app in NSWorkspace.shared.runningApplications {
    let fr = statusItemFrames(pid: app.processIdentifier)
    if !fr.isEmpty {
      print("\(app.localizedName ?? "?")\t\(app.bundleIdentifier ?? "?")\t" + fr.map { "x=\(Int($0.origin.x)) w=\(Int($0.width))" }.joined(separator: " "))
    }
  }
  exit(0)
}

let windows = menuWindows()
let apps = NSWorkspace.shared.runningApplications
for appName in wanted {
  var result = "-", width = 0
  let matches = apps.filter { $0.localizedName == appName || $0.bundleIdentifier == appName }
  search: for app in matches {
    for f in statusItemFrames(pid: app.processIdentifier) {
      // The AX frame is the icon inside the menu bar slot (often inset a few
      // px each side), so match on its center falling inside the slot.
      let cx = f.midX
      for (i, m) in windows.enumerated()
      where m.w > 0 && m.w < 400 && cx >= m.x && cx <= m.x + m.w {
        result = "\(m.owner),\(m.name)(\(i + 1))"; width = Int(m.w)
        break search
      }
    }
  }
  print("\(appName)\t\(result)\t\(width)")
}
