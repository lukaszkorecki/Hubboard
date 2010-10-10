require 'boot'

class Hubboard < Wx::App
  attr_reader :gh_login, :gh_token
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
    t.start(1)
    evt_idle { Thread.pass }

    # lets show some stuff, eh?
    @main_frame = MainFrame.new
    @main_frame.show
  end
end

# we need application instance so that
# it can be used by other classes
App = Hubboard.new

App.main_loop
