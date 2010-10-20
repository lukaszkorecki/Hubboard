class HEventPanel < EventPanel
  def on_init
  end

  def body= event
      @contents_html.page = format_content(event[:content])
      @title_label.label = event[:title]
      @username_link.label = event[:author][:name]
      @username_link.url = event[:author][:url]
  end
  private
  def format_content content
    # FIXME suboptimal
    content.lines.to_a[1..-2].reject { | line | line.chomp.strip.empty? == true }.map do | line|
      line.gsub('&lt;','<').gsub('&gt;','>')
    end.join ""
  end
end
