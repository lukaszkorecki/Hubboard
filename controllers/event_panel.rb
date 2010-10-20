class HEventPanel < EventPanel
  def on_init
  end

  def body= event
      @contents_html.page = event[:content]
      @title_label.label = event[:title]
      @username_link.label = event[:author][:name]
      @username_link.url = event[:author][:url]
  end
end
