class HMainFrame < MainFrame
  include Github

  def on_init
    begin
      @title_list = HHtmlList.new @list_panel
      @list_panel.sizer.add @title_list, 1, Wx::ALL|Wx::GROW
    rescue => e
      STDERR << e.to_yaml
    end

    @entries = []
    @user = ''

    start!


    # setup events
    evt_listbox(@title_list.get_id) { |ev| show_event_content ev }

    evt_html_link_clicked(@details_html.get_id) { |ev| handle_url(ev) }
    evt_html_link_clicked(@event_content.get_id) { |ev| handle_url(ev) }

    evt_close { App.exit_main_loop }

    # map toolbar click to events
    # TODO refactor this once it's all
    # settled
    evt_tool(@see_on_gh_tool) {  handle_url(nil, "https://github.com" ) }
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


  # get dashboard and current user info on startup
  def start!
    get_user_details { |details| show_user_details details }
    get_gh_dashboard { |entries|  show_dashboard entries }
  end

  # process clicks in html windows
  def handle_url event=nil, url_str=nil
    url = url_str || event.link_info.href
    url = "http://github.com#{url}" unless url =~ /^http/
    Wx::launch_in_default_browser url
  end

  # load content and metadata associated with an event
  def show_event_content ev
    @event_content.page = format_content @entries[ev.index][:content]

    @published_label.label = fuzzy_date @entries[ev.index][:published]

    @title_label.label = @entries[ev.index][:title]

    get_user_details @entries[ev.index][:author][:name] do |details|
      show_user_details details
    end


    @gh_visit_link.url = @entries[ev.index][:link]

    ic = App.event_icons.from_title(@entries[ev.index][:title])

    # sometimes loading an image of a known type but with wrong
    # extensions causes wxRuby to throw an error
    begin
      @event_icon.bitmap = Wx::Bitmap.from_image(Wx::Image.new ic)
    rescue => e
      STDERR << "icon error" << e.to_yaml
    end

  end

  # download events asynchronously
  def get_gh_dashboard
    Thread.new do
      @feed ||= Feed.new(:login => App.gh_login, :token => App.gh_token)
      entries = @feed.parse
      yield entries.empty? ? false : entries
      # start the timer after initial dashboard update
      @timer.start 15.minutes
    end

  end

  # update events asynchronously
  def update_gh_dashboard
    Thread.new do
      entries = @feed.parse_and_update
      yield entries.empty? ? false : entries
    end
  end

  # get details of a user
  def get_user_details name = nil
    return if @user == name
    @user = name || {:login => App.gh_login, :token => App.gh_token}
    Thread.new do
      gh_user = User.new(@user)
      yield gh_user
    end
  end

  # view method - load user info into specified html window
  # and her/his avatar
  def show_user_details gh_user
    return github_error if gh_user.data.nil?
    @user_avatar.bitmap = App.url_to_bitmap gh_user.avatar
    @details_html.page = HtmlTemplates::User.to_html gh_user
  end

  # view method - populates the list of events
  def show_dashboard entries

    return github_error unless entries

    length_before = @entries.length
    @entries = entries
    @title_list.set entries.map { |el| "<p>#{el[:title]}</p>" }

    entries[0..(@entries.length-length_before)-1].each do |el|
      App.notify el[:author][:name], el[:title]
    end unless length_before == 0 or (length_before == @entries.length)

    @status_bar.push_status_text "Updated at: #{time_now}", 0
  end

  # thin (Very thin!) wrapper around notification method
  def message(title, text)
    App.notify title, text
  end

  # helper method for notifying about connection/auth problems
  def github_error
    message  'Error', 'Problem connecting with GitHub! Check your settings! (or GitHub is down)'
  end
private

  # helper method - strips out most of the unwanted markup from event content
  def format_content content
    # FIXME suboptimal

    content.lines.to_a.reject{ | l | l =~ /div/ }.reject { | line | line.chomp.strip.empty? == true }.map do | line|
      CGI::unescapeHTML line
    end.join ""
  end

  # fuzzy date helper
  def fuzzy_date(date_a)
    date = DateTime.parse(date_a, true)
    date.to_pretty
  end

  # helper method for formatting date (probably can be done better ;-))
  def time_now
    [].tap do |time|
      [:hour, :min, :sec].each do |num|
        digit = Time.now.send num
        time << ((digit > 9) ? digit : "0#{digit}")
      end
    end.join ':'
  end
end
