class Icons
  def initialize
    @dir = 'assets'
    @icons = YAML::load_file(@dir+"/actions.yaml")
  end
  def get category, action
    @icons[category][action]
  end
end
