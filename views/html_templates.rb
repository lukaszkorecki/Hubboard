# yes, yes... this needs to use erb or sth
# but lets face it... at this stage it needs to work
# as long as the interface doesn't change it stay as it is
# and get faster when it needs to
module HtmlTemplates
  require 'erb'
  class User
    def self.to_html user
      @t = ERB.new " <b> <a href='http://github.com/<%= @login %>'><%= @name%></a> </b>
        <br/>
        <a href='<%= @blog %>'><%= @blog %></a>
        <br>
        Member since: <%= @created_at %>
        <br/>
          <span>Followers: <%= @followers_count %></span>
          <span>Repos: <%= @public_repo_count %></span>
          <span>Gists: <%= @public_gist_count %></span>
      "
      @t.result user.get_binding
    end
  end
end
