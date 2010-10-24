require 'boot'

class Application < Wx::App
  attr_reader :gh_login, :gh_token, :image_cache
  def on_init
    # gh vars
    @gh_login, @gh_token = Github.git_config

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

    # lets show some stuff, eh?
    @main_frame = HMainFrame.new

    @main_frame.size = Wx::Size.new  400, 575
    @main_frame.show

    @image_cache = ImageCache.new('hubboard')
    @image_cache.setup ['avatars']
    @image_cache.rebuild
  end
end

# we need application instance so that
# it can be used by other classes
App = Application.new

App.main_loop


