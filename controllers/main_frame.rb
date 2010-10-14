class HMainFrame < MainFrame
  include Github
  def on_init
    get_user_details { show_user_details }
  end

  def get_user_details
    Thread.new do
      @gh_user = User.new(:login => App.gh_login, :token => App.gh_token)
      if @gh_user
        yield
      else
        # TODO add message method
        puts 'you`re offline!'
      end
    end
  end

  def show_user_details
    @user_name.label = "lol: #{@gh_user.name} #{@gh_user.login}"
    @user_avatar.set_bitmap url_to_bitmap @gh_user.avatar
  end
private
  def url_to_bitmap img_url
    c_img = App.image_cache.do_it img_url, :extension => "png", :subdir => 'avatars'
    img = Wx::Image.new(c_img)
    Wx::Bitmap.from_image(img)
  end
end
