module Wx
  def self.launch_in_default_browser(url)
    case RUBY_PLATFORM
    when /darwin/
      `open #{url}`
    when /linux/
      `xdg-open #{url}`
    when /windows/
      `cmd /c "start #{url}"`
    else
      raise "Can't handle windows for now!"
    end
  end
end
