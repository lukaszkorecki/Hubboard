class MainFrame < Wx::Frame
  include Github
  def on_init
    set_user_details
  end
  def set_user_details
     Thread.new do
      # FIXME this API sucks, the get_user_info needs to be hidden, no blocks here pls
       @gh_user = User.new.info(:login => App.gh_login, :token => App.gh_token) do | auth_data |
        Github.get_user_info auth_data
      end
      @user_name.label = "#{@gh_user["login"]} (#{@gh_user["name"]})"
    end

  end
  def gh_user_label
  end
end
