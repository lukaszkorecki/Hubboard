require File.dirname(__FILE__)+"/../lib/github_feed"
require 'yaml'
 require 'test/unit'
class Github_Feed_Test < Test::Unit::TestCase

  def setup
    puts "loading"
    @gh_feed = Github::Feed.new do
      File.new(File.dirname(__FILE__)+'/test.atom','r').read
    end
    puts @gh_feed.entries.to_yaml
  end
  def test_easy
    assert(Github::Feed, @gh_feed.class)
  end

  def test_loading_feeds
    assert(2, @gh_feed.entries.length)
  end

  def test_structure
    puts @gh_feed.entries.to_yaml
  end
end

=begin INSTALL RSPEC
describe "Github Module" do
  include Github
  describe "Feed" do
    it "should return an object of Github::Feed class" do
       Feed.new('http://example.com').class should be Feed
    end
  end
end
=end
