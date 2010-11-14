require 'boot'

class Application < Wx::App
  attr_reader :gh_login, :gh_token, :image_cache, :event_icons

  def on_init
    # GitHub vars
    notify "Hubboard", "Hello!"

    # image cache for avatars
    @image_cache = ImageCache.new('hubboard')
    @image_cache.setup ['avatars']
    @image_cache.rebuild

    # event icons take fron /assets
    @event_icons = Icons.new


    # Emulate the thread scheduler
    # it is important to remember
    # to test this values
    # and NEVER call Thread.new {}.join!
    # just create a thread, and let the
    # "scheduler" do the rest
    t = Wx::Timer.new(self, 55)
    evt_timer(55) { Thread.pass }
    t.start(100)
    evt_idle { Thread.pass }


    # preferences
    @prefs = Preferences.new
    get_preferences

    # lets show some stuff, eh?
    @main_frame = HMainFrame.new


    @main_frame.size = Wx::Size.new 580, 425
    @main_frame.show
  end

  def get_preferences
    if @prefs.gh_data
      puts @prefs.gh_data.to_yaml
      @gh_login = @prefs.gh_data[:username]
      @gh_token = @prefs.gh_data[:token]
    else
      @preferences_frame ||= HPreferencesFrame.new
      @preferences_frame.show
    end
  end

  def show_prefs
    @preferences_frame ||= HPreferencesFrame.new
    @preferences_frame.show
    @preferences_frame.set_gh_settings @gh_login, @gh_token
  end

  def store_prefs
    username, token = @preferences_frame.gh_settings
    if username and token
      @prefs.store_gh_data username, token
      @gh_login, @gh_token = username, token
      @main_frame.start!
    else
      notify "Error", "Token and username can't be empty!"
    end
  end

  def notify title, message
    @notif ||= Notification.new
    @notif.message title, message
  end

  def url_to_bitmap img_url
    c_img = @image_cache.do_it img_url, :subdir => 'avatars' # , :extension => "jpg"

    # get correct image handler, based on `file` command (emulating mime-types)
    type = `file #{c_img}`.to_s.split(" ")[1]
    handler = Wx.const_get "BITMAP_TYPE_#{type}"

    img = Wx::Image.new(c_img, handler)
    Wx::Bitmap.from_image(img)
  end
end

# we need application instance so that
# it can be used by other classes
App = Application.new

App.main_loop
