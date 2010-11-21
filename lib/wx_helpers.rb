module Wx
  # overrides default popup menu handler
  # for dock icon
  class TaskBarIcon
    def create_popup_menu *args
      STDOUT << "lol"
      nil
    end
  end

  # opens an url in default browser
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
