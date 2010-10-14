# Bootstrap file for Hubboard

# Add vendor directories to load path
Dir["vendor/**/lib"].each do |lib_path|
  $LOAD_PATH << lib_path
end

# load vendor libs
require 'json'
require 'simple_http'
require 'wx'

# stuff
require 'yaml'

# application classes
require 'lib/default_browser'
require 'lib/image_cache'
require 'lib/github'

# MVC
# loads frames (views) and controllers automatically
# technicaly controllers and views are the same
# here's an explanation:
# - view -> a class generated from .xrc file by xrcise tool, SHOULDN'T BE CHANGED
# - controller -> the same class, but opened in a different class with 
#                 all the extra code added (events, getting data from models, etc)
Dir["views/*.rb"].each do |frame_file|
  require frame_file.sub(".rb","")
end
Dir["controllers/*.rb"].each do |event_file|
  require event_file.sub(".rb","")
end
Dir["models/*.rb"].each do |model_file|
  require model_file.sub(".rb","")
end

APP_INFO = YAML::load_file('app.yml')
