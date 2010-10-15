# yes, yes... this needs to use erb or sth
# but lets face it... at this stage it needs to work
# as long as the interface doesn't change it stay as it is
# and get faster when it needs to
module HtmlTemplates
  require 'erb'
  class User
    def self.to_html user
      @t = ERB.new "<div>
      <p>
        <a href='http://github.com/<%= @login %>'><%= @login %></a>
        <br>
        <a href='<%= @blog %>'><%= @blog %></a>
        <br>
        Member since: <%= @created_at %>
      </p>
      <p>
        <ul>
          <li>Followers: <%= @followers_count %></li>
          <li>Repos: <%= @public_repo_count %></li>
          <li>Gists: <%= @public_gist_count %></li>
        </ul>
      </p>"
      @t.result user.get_binding
    end
  end
end
