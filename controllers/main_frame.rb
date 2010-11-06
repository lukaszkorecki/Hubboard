class HMainFrame < MainFrame
  include Github
  def on_init
    @entries = []
    @user = ''
    get_user_details { |details| show_user_details details }
    get_gh_dashboard { |entries|  show_dashboard entries }

    evt_listbox(@title_list.get_id) { |ev| show_event_content ev }
    evt_button(@visit_button.get_id) { Wx::launch_in_default_browser @current_url}
  end

  def show_event_content ev
    @event_content.page = format_content @entries[ev.index][:content]
    @published_label.label = fuzzy_date @entries[ev.index][:published]
    @title_label.label = @entries[ev.index][:title]
    get_user_details @entries[ev.index][:author][:name] do |details|
      show_user_details details
    end
    @current_url = @entries[ev.index][:link]
    ic = App.event_icons.from_title(@entries[ev.index][:title])
    @event_icon.bitmap = Wx::Bitmap.from_image(Wx::Image.new ic)
  end
  def get_gh_dashboard
    Thread.new do
      entries = Feed.new(:login => App.gh_login, :token => App.gh_token).parse
      yield entries.empty? ? false : entries
    end
  end
  def get_user_details name = nil
    return if @user == name
    @user = name || {:login => App.gh_login, :token => App.gh_token}
    Thread.new do
      gh_user = User.new(@user)
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
    @entries = entries + @entries
    ti = entries.map { |el| el[:title] }
    @title_list.insert_items ti, 0
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
private
  def format_content content
    # FIXME suboptimal

    content.lines.to_a.reject{ | l | l =~ /div/ }.reject { | line | line.chomp.strip.empty? == true }.map do | line|
      CGI::unescapeHTML line
    end.join ""
  end
  def fuzzy_date(date_a)
    date = DateTime.parse(date_a, true)
    date.to_pretty
  end
end
