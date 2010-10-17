class HEventPanel < EventPanel
  def on_init
    evt_togglebutton @contents_toggle.get_id { | event | toggle_contents }
  end

  def toggle_contents
    if @contents_toggle.value
      @contents_html.page = @html unless @html.nil?
      @contents_html.show
    else
      @contents_html.hide
    end
    @html = nil
  end
  def body= event
    begin
      @html = event[:contents]
      @title_label.label = event[:title]
      @user_link.label = event[:author][:name]
      @user_link.url = event[:author][:uri]
    rescue => e
      STDOUT << e.to_yaml
    end
  end
end
