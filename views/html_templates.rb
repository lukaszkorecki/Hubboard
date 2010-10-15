# yes, yes... this needs to use erb or sth
# but lets face it... at this stage it needs to work
# as long as the interface doesn't change it stay as it is
# and get faster when it needs to
module HtmlTemplates
  class User
    def self.to_html user
      @u = user
      t = "<div>
      <p>
        <a href='http://github.com/#{ @u.login }'>#{ @u.login }</a>
        <br>
        <a href='#{ @u.blog }'>#{ @u.blog }</a>
        <br>
        Member since: #{ @u.created_at }
      </p>
      <p>
        <ul>
          <li>Followers: #{ @u.followers_count }</li>
          <li>Repos: #{ @u.public_repo_count }</li>
          <li>Gists: #{ @u.public_gist_count }</li>
        </ul>
      </p>"
    end
  end
end
