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
    it { should have(1).ng_words }
  end

  context 'with argument "foo","bar"' do
    subject { MessageFilter.new("foo", "bar") }
    it { should be_detect("hello from foo") }
    it_should_behave_like 'exercise with argument "foo"'
    it { should have(2).ng_words }
  end
  
  context 'with argument "foo" attribute with ignore_case' do
    subject {
      m = MessageFilter.new("foo")
      m.ignore_case = true
      m
    }
    its(:ignore_case) { should be_true }
    it { should be_detect("hello from foo") }
    it_should_behave_like 'exercise with argument "foo"'
    it { should be_detect("hello FOO") }
    it { should have(1).ng_words }
  end

  context 'with argument "FOO" attribute with ignore_case' do
    subject {
      m = MessageFilter.new("FOO")
      m.ignore_case = true
      m
    }
    its(:ignore_case) { should be_true }
    it { should be_detect("hello from foo") }
    it_should_behave_like 'exercise with argument "foo"'
    it { should be_detect("hello FOO") }
    it { should have(1).ng_words }
  end

  context 'with argument "foo" attribute with not ignore_case' do
    subject {
      m = MessageFilter.new("foo")
      m.ignore_case = false
      m
    }
    its(:ignore_case) { should be_false }
    it { should be_detect("hello from foo") }
    it_should_behave_like 'exercise with argument "foo"'
    it { should_not be_detect("hello FOO") }
    it { should have(1).ng_words }
  end

end


