class HMainFrame < MainFrame
  include Github
  def on_init
    @timeline_scroller.sizer.layout
    @timeline_scroller.set_scrollbars(20,20, 20,20,0,0,true)

    get_user_details { show_user_details }
    Thread.new do
      (1..10).each do
        begin
          p = HEventPanel.new @timeline_scroller
          p.body = "<p>Lorem ipsum dolor sit amet, consectetur magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>"
          @timeline_scroller.sizer.add p, Wx::ID_ANY, Wx::GROW|Wx::ALL
        rescue => e
          STDOUT << e.to_yaml
        end
      end
    end
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
    @user_name.label = @gh_user.name # (#{@gh_user.login})"
    @user_avatar.bitmap = url_to_bitmap @gh_user.avatar
    @details_html.page = HtmlTemplates::User.to_html @gh_user
  end
private
  def url_to_bitmap img_url
    c_img = App.image_cache.do_it img_url, :extension => "png", :subdir => 'avatars'
    img = Wx::Image.new(c_img)
    Wx::Bitmap.from_image(img)
  end
end
