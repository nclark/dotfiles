module Project
  extend self

  def directories
    Dir.glob(File.expand_path("~/workspace/*/*")).reject {|d| !File.directory?(d)}
  end

  def list
    directories.map {|dir| (dir.match /^.+\/(.*)$/)[1].strip }.join(' ')
  end

  def find(name)
    directories.grep(/\/#{name}$/).first
  end
end
