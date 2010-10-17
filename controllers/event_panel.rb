class HEventPanel < EventPanel
  def body= html
    @contents_html.page = html
  end
end
