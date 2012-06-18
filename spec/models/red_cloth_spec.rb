require 'spec_helper'
require 'RedCloth'

describe RedCloth::TextileDoc do
  subject { RedCloth.new('h1. Red Foo, a TRUE party rocka!')}
  it 'can drop-in replace String' do
    subject.should == 'h1. Red Foo, a TRUE party rocka!'
    subject.to_s.should == 'h1. Red Foo, a TRUE party rocka!'
  end
  it 'returns HTML for textile with to_html' do
    subject.to_html.should == "<h1>Red Foo, a <span class=\"caps\">TRUE</span> party rocka!</h1>"
  end
  # it 'implements the mongoid custom serialization' do
  #   subject.responds_to(:serialize) responds_to(:deserialize)
  # end
  context '# mongoid serialize' do
    it 'can be read/written from mongoid as a string' do
      c = Content.build('redfoo', 'field :textile, type:RedCloth::TextileDoc')
      c.textile = 'h1. Red Foo, a TRUE party rocka!'
      c.save
      d = Content.find(c.id)
      d.textile.should == 'h1. Red Foo, a TRUE party rocka!' 
    end
  end
end