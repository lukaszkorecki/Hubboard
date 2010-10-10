class MainFrame < Wx::Frame
  def on_init
    @user_name.label = App.gh_login
  end
end
