class ImageCache
  require 'net/http'
  require 'uri'
  require 'fileutils'

  attr_reader :cached_list
  # @param dir_name String = name of the image cache folder
  # by default it creates a directory prefixed with . (hidden in UNIX systems)
  def initialize dir_name="my_image_cache"
    @ds = File::SEPARATOR
    dir_name = ".#{dir_name}" unless dir_name.start_with? '.'
    @root = "#{File.expand_path("~")}#{@ds}#{dir_name}"
    @cached_list = {}
  end

  # creates the image cache directory (if it doesnt exist)
  # and any additional subdirectories passed as an array
  # @param subdirs Array = names of additional subdirectories stored in cache folder
  def setup subdirs
    FileUtils.mkdir_p @root
    if subdirs and subdirs.length > 0
      subdirs.each do |subdir|
        FileUtils.mkdir_p "#{@root}#{@ds}#{subdir}"
      end
      @subdirs = subdirs
    end
  end

  # rebuild the cached file list
  def rebuild
    ["jpeg", "jpg", "png", "gif"].each do |type|
      p = "#{@root}#{@ds}**#{@ds}*.#{type}"
      Dir[p].each do |path|
        @cached_list[path.split(@ds).last] ||= path
      end
    end
    @cached_list
  end

  # stores or retrieves the path to the file based on its url
  # and image cache subdir
  # @param url String = url to the file (http://example.com/img/elo.jpg)
  # @param subdir String = optional subdirectory (needs to be created in setup())
  def do_it  url, config
    subdir = config[:subdir] if config.key? :subdir
    extension = config[:extension] if config.key? :extension
    file_name = url.split("/").last.gsub(/\W/,'')
    path = [@root, @ds]
    path << "#{subdir}#{@ds}" if subdir
    path << file_name
    path << ".#{extension}" if extension
    @cached_list[file_name] ||= save_to_disk(url, path.join(""))
  end

private
  # downloads the file of given url and stores it in the given path
  # @param url - url to the file
  # @param target_name - path to the cached file
  def save_to_disk url,  target_name
    from_url = URI.parse url
    Net::HTTP.start(from_url.host) do |http|
      resp = http.get(from_url.path)
      open(target_name, "wb") do |file|
        begin
          file.write(resp.body)
        rescue => err # FIXME don't fail on failed write (OTOH it's better it have no image than crash the whole app)
          return nil
        end
        return target_name
      end
    end
  end
end
