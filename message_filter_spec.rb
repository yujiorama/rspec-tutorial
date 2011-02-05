require 'rubygems'
require 'rspec'
require 'message_filter'

describe MessageFilter do
  share_examples_for 'exercise with argument "foo"' do
    it { should be_detect("hello from foo") }
    it { should_not be_detect("hello world") }
    its(:ng_words) { should_not be_empty }
  end

  context 'with argument "foo"' do
    subject { MessageFilter.new("foo") }
    it_should_behave_like 'exercise with argument "foo"'
    it 'ng_wors size is 1' do
      subject.ng_words.size.should == 1
    end
  end

  context 'with argument "foo","bar"' do
    subject { MessageFilter.new("foo", "bar") }
    it { should be_detect("hello from foo") }
    it_should_behave_like 'exercise with argument "foo"'
  end
end


