class HMainFrame < MainFrame
  include Github
  def on_init

    @entries = []
    @user = ''

    start!

    # setup events
    evt_listbox(@title_list.get_id) { |ev| show_event_content ev }

    evt_button(@visit_button.get_id) { Wx::launch_in_default_browser @current_url}

    evt_html_link_clicked(@details_html.get_id) { |ev| handle_url(ev) }
    evt_html_link_clicked(@event_content.get_id) { |ev| handle_url(ev) }

    # map toolbar click to events
    # TODO refactor this once it's all
    # settled
    evt_tool(@preferences_tool) { App.show_prefs }

    evt_tool(@refresh_tool) do
      refresh_gh_dashboard do |entries|
        show_event_content entries
      end
    end
    # get dashboard and current user info
    get_user_details { |details| show_user_details details }
    get_gh_dashboard { |entries|  show_dashboard entries }

    evt_tool(@refresh_tool) do
        update_gh_dashboard do |entries|
          show_dashboard entries
        end
    end

    # setup timer
    # make it check github dashboard every 15 minutes
    evt_timer(31337) do
      update_gh_dashboard do |entries|
        show_dashboard entries
      end
    end
    @timer = Wx::Timer.new self, 31337
  end

  def start!
    # get dashboard and current user info on startup
    get_user_details { |details| show_user_details details }
    get_gh_dashboard { |entries|  show_dashboard entries }
  end

  def handle_url event
    url = event.link_info.href
    url = "http://github.com#{url}" unless url =~ /^http/
    Wx::launch_in_default_browser url
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
    begin
      @event_icon.bitmap = Wx::Bitmap.from_image(Wx::Image.new ic)
    rescue => e
      STDOUT << e.to_yaml
    end

  end

  def get_gh_dashboard
    Thread.new do
      @feed ||= Feed.new(:login => App.gh_login, :token => App.gh_token)
      entries = @feed.parse
      yield entries.empty? ? false : entries
      # start the timer after initial dashboard update
      @timer.start 900000 # 15 minutes
    end

  end

  def update_gh_dashboard
    Thread.new do
      entries = @feed.parse_and_update
      yield entries.empty? ? false : entries
    end
  end

  def get_user_details name = nil
    return if @user == name
    @user = name || {:login => App.gh_login, :token => App.gh_token}
    STDOUT << @user.inspect
    Thread.new do
      gh_user = User.new(@user)
      yield gh_user
    end
  end

  def show_user_details gh_user
    return github_error if gh_user.data.nil?
    @user_avatar.bitmap = App.url_to_bitmap gh_user.avatar
    @details_html.page = HtmlTemplates::User.to_html gh_user
  end

  def show_dashboard entries

    return github_error unless entries

    length_before = @entries.length
    STDOUT << length_before
    @entries = entries
    @title_list.set entries.map { |el| el[:title] }

    entries[0..(@entries.length-length_before)].each do |el|
      App.notify el[:author][:name], el[:title]
    end unless length_before == 0 or (length_before == @entries.length)

    @status_bar.push_status_text "Updated at: #{time_now}", 0
  end

  def message(title, text)
    App.notify title, text
  end

  def github_error
    message  'Error', 'Problem connecting with GitHub! Check your settings! (or GitHub is down)'
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
  def time_now
    [].tap do |time|
      [:hour, :min, :sec].each do |num|
        digit = Time.now.send num
        time << ((digit > 9) ? digit : "0#{digit}")
      end
    end.join ':'
  end
end
