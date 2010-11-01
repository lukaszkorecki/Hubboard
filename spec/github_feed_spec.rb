require File.dirname(__FILE__)+"/../lib/github/feed"

describe "Github Module" do
  describe "Feed" do
    before :each do
      @atom ||= File.new(File.dirname(__FILE__)+'/fixtures/test.atom','r').read
      @atom_update ||= File.new(File.dirname(__FILE__)+'/fixtures/test_update.atom','r').read

      @entry_c ||= File.new(File.dirname(__FILE__)+"/fixtures/entry.xml",'r').read
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

      Github.stub!(:get_feed).and_return @atom

      @ghf = Github::Feed.new
    end
    it "should assign file contents to feed content by default" do
      ghf = Github::Feed.new
      ghf.feed_content.should == @atom
    end
    it "should assign feed content if passed as a block" do
      @ghf.content do
        @atom
      end
      @ghf.feed_content.should == @atom
    end

    it "should assign via function call" do
      @ghf.content @atom
      @ghf.feed_content.should == @atom
    end
    it 'should return false if feed wasnt retreivedj' do
      Github::Feed.new { false }.entries == false
    end

    it "should assign feed content via block" do
      ghf = Github::Feed.new { @atom }
      ghf.feed_content.should == @atom
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
        it 'should not unescape html entities' do
          @e[:content].should == "&lt;p&gt;some HTML content&lt;/p&gt;"
        end

      end

      describe "should store parsed entries in correct order" do
        it "should fill the entries in order" do
          @entries.first[:gh_id].should == '2008331221216'
          @entries[1][:gh_id].should == '2008331210264'
        end
        it "should not add entries which exist already" do
          @f.content  { @atom }
          @f.parse
          @f.entries.length.should == 2
        end

      end
      describe "adding/updating entries" do
        before :each do
          @f.content { @atom_update }
          @f.parse_and_update
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
