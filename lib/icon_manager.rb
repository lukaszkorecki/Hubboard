class Icons
  def initialize
    @dir = 'assets'
    @icons = YAML::load_file(@dir+'/actions.yaml')
  end
  def get category, action
    @dir+'/'+@icons[category][action]
  end

  def from_title title
    case title
      # wiki
      when /edited.*wiki/
        get 'wiki', 'edited'
      # gist
      when /created.*gist/
        get 'gist', 'created'
      when /updated.*gist/
        get 'gist', 'updated'
      # repos
      when /created.*repository/
        get 'repo', 'created'
      when /forked/
        get 'repo', 'forked'
      when /pushed to/
        get 'repo', 'pushed'
      when /commented on/
        get 'repo','commented'
      when /applied fork commits/
        get 'repo','applied'
      when /created tag/
        get 'repo', 'created_tag'
      when /created branch/
        get 'repo', 'created_branch'
      # pull requests
      when /opened pull request/
        get "pull_request", 'opened'
      when /closed pull request/
        get "pull_request", 'closed'
      # issues
      when /opened issue/
        get "issue", 'opened'
      when /closed issue/
        get "issue", 'closed'
      # watching
      when /started watching/
        get "users", 'started_watching'
      when /started following/
        get "users", 'started_following'
      else
        get 'repo', 'forked'
    end
  end
end
