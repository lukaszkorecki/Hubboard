class HEventPanel < EventPanel
  attr_reader :details_html
  def on_init
    @details_html.page = "Lorem ipsum dolor sit amet, consectetur magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum<++>\<c-o>:normal! gqq\<CR>"
  end
  def show event
    # TODO show event stuff
    # o
  end
end
