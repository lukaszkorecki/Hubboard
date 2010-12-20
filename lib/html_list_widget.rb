class HHtmlList < Wx::HtmlListBox
  def initialize *args
    STDERR << args.inspect
    super *args
  end
  def on_init *args
    STDERR << args.inspect
    super *args
  end

  def on_get_item *args
    STDERR << args.inspect
    "<div><pre>#{args.inspect}</pre><p>boo!</p></div>"
  end
end
