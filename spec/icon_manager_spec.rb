require File.dirname(__FILE__)+'/../lib/icon_manager'
require 'yaml'


describe Icons do
  it 'should load yaml list of icons with categories' do
    Icons.new.get("wiki", "edited").should == "assets/document--plus.png"
  end
  context "Title parsing" do |variable|
    before :each do
      @icons = Icons.new
    end
    it 'should parse gist creation title' do
      @icons.from_title("tpope created gist: 643979").should == 'assets/document--plus.png'
    end
    it 'should parse "wiki edited" title' do
      tit = "dantebronto edited a page in the dantebronto/picard wiki "
      @icons.from_title(tit).should == "assets/document--plus.png"
    end
    it 'should get following icon' do
      tit = 'mlen started following eventmachine 1 day ago'
      @icons.from_title(tit).should == 'assets/user--plus.png'
    end
    context "pull requests" do
      it 'get "pull request open" icon' do
        tit = 'paneq opened pull request 87'
        @icons.from_title(tit).should == 'assets/bandaid--plus.png'
      end
      it 'should get "closed pullreq" icon' do
        tit = 'lojjic closed pull request 77 on lojjic/PIE a'
        @icons.from_title(tit).should == 'assets/bandaid--pencil.png'
      end
    end
    context "repository events" do
      it 'should get repo created icon' do
        tit = "c9s created repository go-lang.vim"
        @icons.from_title(tit).should == 'assets/block--plus.png'
      end
      it 'should get repo forked icon' do
        tit = 'c9s forked tokuhirom/p5-Furl'
        @icons.from_title(tit).should == 'assets/cutlery-fork.png'
      end
      it "should get 'pushed to repo' icon" do
        tit = 'tenderlove pushed to master at rails/rails about 17 hou'
        @icons.from_title(tit).should == 'assets/block--arrow.png'
      end
      it 'should get apply commits icon' do
        tit = 'andreyvit applied fork commits to livereload/master 1 day ago'
        @icons.from_title(tit).should == 'assets/block--pencil.png'
      end
      it 'should get tag created icon' do
        tit = 'pdc created tag 2010.10'
        @icons.from_title(tit).should == 'assets/tag--plus.png'
      end
    end
    context 'issues' do
      it 'should get issue open icon' do
        tit = 'lojjic opened issue 81 on lojji'
        @icons.from_title(tit).should == 'assets/ticket--plus.png'
      end
      it 'should get issue close icon' do
        tit = 'lojjic closed issue 81 on lojji'
        @icons.from_title(tit).should == 'assets/ticket--pencil.png'
      end
    end
  end
end
