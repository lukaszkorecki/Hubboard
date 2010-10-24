class HEventPanel < EventPanel
  def on_init
    evt_button(@ghlink_button.get_id) { Wx::launch_in_default_browser @link}
  end

  def body= event
    @link = event[:link]
    @contents_html.page = format_content(event[:content])
    @title_label.label =  event[:title]
    @published_label.label = fuzzy_date event[:published]
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
