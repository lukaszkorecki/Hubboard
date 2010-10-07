require File.dirname(__FILE__)+"/../lib/github/feed"

describe "Github Module" do
  describe "Feed" do
    before :each do
      @ghf = Github::Feed.new

      @atom ||= File.new(File.dirname(__FILE__)+'/test.atom','r').read
      @atom_update ||= File.new(File.dirname(__FILE__)+'/test_update.atom','r').read

      @entry_c ||= File.new(File.dirname(__FILE__)+"/entry.xml",'r').read
      @entry ||= REXML::Document.new(@entry_c).root

      xml =<<-XML
        <author>
          <name>
            yo
          </name>
          <uri>http://example.com</uri>
        </author>
      XML
      @rxml ||= REXML::Document.new(xml)
    end
    it "should assign file contents to @entries" do
      r = Github::Feed.new do
        @atom
      end
      r.feed_content.should == @atom
      @ghf.content = @atom
      @ghf.feed_content.should == @atom
    end
    it "should not assign anythong to feed_content if block isn't passed" do
      @ghf.feed_content.should == nil
    end
    it "should get data from an xml tag" do
      @ghf.send(:get_data_from_element, @rxml.root, 'name' ).strip.should == 'yo'
      @ghf.send(:get_data_from_element, @rxml.root, 'uri' ).strip.should == 'http://example.com'
    end
    it "should get author data from xml" do
      @ghf.send(:get_author, @rxml).should == {
        :name => 'yo',
        :url => 'http://example.com'
      }
    end
    describe "Parsing" do
      before :each do
        @f = Github::Feed.new do
          @atom
        end
        @entries = @f.parse.entries
        @e = @f.parse_entry('001', @entry)
      end
      it "should parse the the test feed and get two entries" do
        @entries.length.should == 2
        @f.id_list.length.should == 2
      end
      it "should parse first entry and create a hash of proper structure" do
        [:gh_id, :content, :title, :link, :author, :published].each do | k |
          @e.key?(k).should == true
        end
      end
      describe "should get correct contents for specific keys" do
       it "gets id"  do
          @e[:gh_id].should == '001'
        end
        it "gets title" do
          @e[:title].should == 'foo pushed to master at test/example'
        end
        it "get url from an attribute" do
          @e[:link].should == 'http://example.com/001'
        end
        
      end
      
      describe "should store parsed entries in correct order" do
        it "should fill the entries in order" do
          @entries.first[:gh_id].should == '2008331221216'
          @entries[1][:gh_id].should == '2008331210264'
        end
        it "should not add entries which exist already" do
          @f.content = @atom
          @f.parse
          @f.entries.length.should == 2
        end
        
      end
      describe "adding/updating entries" do
        before :each do
          @f.content = @atom_update
          @f.parse_and_upade
        end
        it "should add new entries" do
          @f.entries.length.should == 4
        end
        it "should append new entries and preserve their order" do
          ['20990833400000', '2008973314005500', '2008331221216', '2008331210264'].each_with_index do | gh_id, index|
            
            @f.entries[index][:gh_id].should == gh_id
          end
        end
        
      end
    end
  end
end
