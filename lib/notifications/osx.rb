class Notification
  def initialize
    setup
  end
  def setup
    root = File.expand_path File.dirname(__FILE__)+'/../..'
    Growl.bin_path = "#{root}/bin/growlnotify"
    @icon = "#{root}/assets/icon_256.png"
    @set = true
  end
  def message title="Hubboard", message_str='', icon=nil
    op = { :title => title, :icon => (icon || @icon) }
    Growl.notify message_str, op
    sleep 0.2
  end
end
