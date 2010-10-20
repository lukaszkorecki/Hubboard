class HMainFrame < MainFrame
  include Github
  def on_init
    @timeline_scroller.sizer.layout
    @timeline_scroller.set_scrollbars(20,20, 20,20,0,0,true)

    get_user_details { show_user_details }
    get_gh_dashboard { show_dashboard }
  end

  def get_gh_dashboard
    Thread.new do
      @entries = Feed.new { Github.get_feed App.gh_login, App.gh_token }.parse.entries
      if @entries
        yield
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
  def show_dashboard
    @entries.each do |element|
      ev = HEventPanel.new @timeline_scroller
      ev.body = element
      @timeline_scroller.sizer.add ev, 1, Wx::GROW|Wx::ALL
    end
  end
private
  def url_to_bitmap img_url
    c_img = App.image_cache.do_it img_url, :extension => "png", :subdir => 'avatars'
    img = Wx::Image.new(c_img)
    Wx::Bitmap.from_image(img)
  end
end
