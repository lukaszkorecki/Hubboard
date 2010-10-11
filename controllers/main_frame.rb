class HMainFrame < MainFrame
  include Github
  def on_init
  get_user_details { show_user_details }
  end

  def get_user_details
#Thread.new do
      @gh_user = User.new(:login => App.gh_login, :token => App.gh_token)
      if @gh_user
        yield
      else
        # TODO add message method
      end
#    end
  end

  def show_user_details
    @user_name.label = "lol: #{@gh_user.name} #{@gh_user.login}"

    img = 'assets/nn_standard.png' #App.image_cache.do_it @gh_user.avatar, {:extension => "png", :subdir => 'avatars'}
#@user_avatar.set_bitmap(Wx::Bitmap.from_image(img))
  end
end
