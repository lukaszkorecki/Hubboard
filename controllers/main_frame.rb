class HMainFrame < MainFrame
  include Github
  def on_init
    @timeline_scroller.sizer.layout
    @timeline_scroller.set_scrollbars(20,20, 20,20,0,0,true)

    get_user_details { |details| show_user_details details }
    get_gh_dashboard { |entries|  show_dashboard entries }
  end

  def get_gh_dashboard
    Thread.new do
      entries = Feed.new(:login => App.gh_login, :token => App.gh_token).parse
      yield entries.empty? ? false : entries
    end
  end
  def get_user_details
    Thread.new do
      gh_user = User.new(:login => App.gh_login, :token => App.gh_token)
      yield gh_user
    end
  end

  def show_user_details gh_user
    return missing_gh_cred if gh_user.data.nil?

    @user_avatar.bitmap = App.url_to_bitmap gh_user.avatar
    @details_html.page = HtmlTemplates::User.to_html gh_user
  end
  def show_dashboard entries
    return missing_gh_cred unless entries

    entries.each do |element|
      begin
        ev = HEventPanel.new @timeline_scroller
        ev.body = element
        @timeline_scroller.sizer.add ev, 1, Wx::GROW|Wx::ALL
        @timeline_scroller.layout
      rescue => e
        STDOUT << e.to_yaml
      end
    end
    @timeline_scroller.layout
  end
  def message(title, text)
    m = Wx::MessageDialog.new(self, text, title, Wx::OK | Wx::ICON_INFORMATION)
    m.show_modal()
    true
  end

  def missing_gh_cred
    message  APP_CONST['messages']['gitconfig_missing']['title'], APP_CONST['messages']['gitconfig_missing']['content'] unless @message_seen
    @message_seen = true
  end
end
