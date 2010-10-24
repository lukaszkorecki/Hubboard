require File.dirname(__FILE__)+'/../lib/pretty_date'

describe "Fuzzy date formatting" do
  context "should produce fuzzy dates based on examples" do
    it 'should say "just now" for 0 seconds ago' do
      Time.stub_chain(:now, :to_i).and_return(0)
      DateTime.parse('1970-01-01T00:00:00+00:00').to_pretty.should == 'just now'
      Time.stub_chain(:now, :to_i).and_return(300)
      DateTime.parse('1970-01-01T00:05:00+00:00').to_pretty.should == 'just now'
    end
    it 'should say "5 minutes" ago' do

      Time.stub_chain(:now, :to_i).and_return(300)
      DateTime.parse('1970-01-01T00:00:00+00:00').to_pretty.should == '5 minutes ago'
    end
    it 'should say "20 hours ago"' do

      Time.stub_chain(:now, :to_i).and_return(75600)
      DateTime.parse('1970-01-01T00:05:00+00:00').to_pretty.should == '20 hours ago'
    end
    it 'should say "a week ago"' do

      Time.stub_chain(:now, :to_i).and_return(1036800)
      DateTime.parse('1970-01-01T00:05:00+00:00').to_pretty.should == 'a week ago'
    end
  end
end
