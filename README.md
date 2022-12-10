
<a href="https://raw.githubusercontent.com/nclark/dotfiles/master/.config/yadm/screen1.png"><img src="https://github.com/nclark/dotfiles/blob/master/.config/yadm/screen1-thumb.png" width="412"/></a>
<a href="https://raw.githubusercontent.com/nclark/dotfiles/master/.config/yadm/screen2.png"><img src="https://github.com/nclark/dotfiles/blob/master/.config/yadm/screen2-thumb.png" width="412"/></a>

---

## Main projects used
* Window manager: [koekeishiya/yabai](https://github.com/koekeishiya/yabai)
* Keyboard shortcuts: [koekeishiya/skhd](https://github.com/koekeishiya/skhd)
* Status bar: [FelixKratz/SketchyBar](https://github.com/FelixKratz/SketchyBar)
* Terminal: [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty)
* Editors: [qvacua/vimr](https://github.com/qvacua/vimr), [neovim/neovim](https://github.com/neovim/neovim)
* File manager: [ranger/ranger](https://github.com/ranger/ranger)
* Dotfiles manager: [TheLocehiliosan/yadm](https://github.com/TheLocehiliosan/yadm)

_Inspiration: [r/unixporn](https://old.reddit.com/r/unixporn)_

## Initial setup

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off
brew install yadm gpg
yadm clone git@github.com:nclark/dotfiles.git
git clone [other repo] $HOME/workspace/dotfiles-private
$HOME/.config/bin/install-packages
$HOME/.config/bin/install-asdf-packages
yadm decrypt
yadm alt
mas signin # Note - currently broken for M1, signin via app store
$HOME/.config/bin/install-macapps
sudo reboot # launchctl is too confusing... just let it pick up the new service
```


## Work vs. Personal machine
- Set [yadm class](https://yadm.io/docs/alternates#)
- Personal: `yadm config local.class Personal`
- Work: `yadm config local.class Work`
- Access class: `yadm config --get local.class`

## Encrypt files
- Add
  - Add to `.config/yadm/encrypt`
  - `yadm encrypt`
  - `cd $HOME/workspace/dotfiles-private ; ./commit`
- Install
  - `yadm decrypt`
- List
  - `yadm decrypt -l`

## Notes

### yabai
- [SIP](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)
- [Scripting
  addition](https://github.com/koekeishiya/yabai/wiki)
- In System Preferences, navigate to Mission Control and uncheck
  the option "Automatically rearrange Spaces based on most recent use"
- `brew install koekeishiya/formulae/yabai`
- `sudo yabai --install-sa`
- `brew services start yabai`
- After upgrade
  - `sha256sum /opt/homebrew/bin/yabai | awk '{print $1}' | pbcopy`
  - `sudo visudo -f /private/etc/sudoers.d/yabai`
  - update checksum
  - `brew services restart yabai`

### skhd
- `brew install koekeishiya/formulae/skhd`
- `brew services start skhd`

### sketchybar
- `brew services start sketchybar`
- On work machine, edit `/usr/local/Cellar/sketchybar/[version]/homebrew.mxcl.sketchybar.plist`
- Add to the EnvironmentVariables section of the property list
```
<key>WORK_MACHINE</key>
<string>true</string>
```

### norg
- `CC=/opt/homebrew/bin/gcc-12 nvim`
- `:TSInstall norg`

### Librewolf
- [bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [floccus](https://addons.mozilla.org/en-US/firefox/addon/floccus/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)
- [Cookie Popup Blocker](https://addons.mozilla.org/en-US/firefox/addon/cookie-popup-blocker/)
- [shut up cookies](https://github.com/OhMyGuus/I-Dont-Care-About-Cookies)
- [google containers](https://github.com/containers-everywhere/contain-google)
- `about:config` -> `full-screen-api.macos-native-full-screen` -> true

### Chromium
  - [Chromium Web Store](https://github.com/NeverDecaf/chromium-web-store)
  - [bitwarden](https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb)
  - [shut up cookies](https://github.com/OhMyGuus/I-Dont-Care-About-Cookies)

### neovim
- `/Library/Developer/CommandLineTools/usr/bin/python3 -m pip install --upgrade pip`
- `python3 -m pip install --user --upgrade pynvim`
- `:PlugInstall`
- `:UpdateRemotePlugins`
- M1 workaround
  ```
    cd $HOME/.vim/plugged/LanguageClient-neovim
    ./install.sh
  ```

### syncthing
- `brew services start syncthing`
- Visit http://localhost:8384

### Amphetamine
- Download Amphetamine Enhancer: https://github.com/x74353/Amphetamine-Enhancer

## Start on launch
- Amphetamine
- Bartender
- Better Touch Tool
- Cleanshot X
- Flux
- MeetingBar
- Nextcloud
- Things Helper

---

# THESE ARE MY DOTFILES

![gary](https://github.com/nclark/dotfiles/blob/master/.config/yadm/gary.jpg)

