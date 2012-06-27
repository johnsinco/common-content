require 'spec_helper'

describe Entry do
  it 'has a title' do
    should respond_to :title
  end
  it 'has a body ' do
    should respond_to :body
  end
  it 'requires body' do
    subject.body = nil
    subject.should be_invalid
    subject.body = 'foo'
    subject.slug = 'foo'
    subject.should be_valid
  end

  it 'does not allow children' do
    subject = Entry.new(slug:'foo', body:'foo')
    subject.child_contents.build(slug:'blargh')
    subject.should be_invalid
    subject.child_contents = nil
    subject.should be_valid
  end

  it 'returns html for the to_html method' do
    subject.title = 'this is a &copy; copyright'
    subject.body = 'this is a paragraph'
    subject.body.should respond_to :to_html
    subject.title.should respond_to :to_html
    subject.title.to_html.should == "<p>this is a &copy; copyright</p>"
    subject.body.to_html.should == "<p>this is a paragraph</p>"
  end
  it 'can save and retrieve the textile' do
    subject.title = 'this is a &copy; copyright'
    subject.body = 'this is a paragraph'
    subject.slug = 'foo'
    subject.save!
    subject.reload   
    subject.title.to_html.should == "<p>this is a &copy; copyright</p>"
    subject.body.to_html.should == "<p>this is a paragraph</p>"
  end
end