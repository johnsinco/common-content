require 'spec_helper'

describe Links do
  let(:content) { Content.build('link-holder', 'field :link, type: Links')}
  context '#single' do
    it 'allows specifying a single URL' do
      Links.new(['foo.html']).should == ['foo.html']
    end
    it 'can be used within a Content' do
      content.save
      content.link = ['one.html']
      content.save
      content.reload
      content.link.should == ['one.html']
    end
    it 'provides a macro to restrict to a single link' do
    end
  end

  context '#multiple' do
    it 'provides a macro to restrict to a specified range of links' do
    end
    it 'allows specifying a number of links' do
      l = Links.new(['foo.html', 'two.html', '3.html'])
      l.should == ['foo.html', 'two.html', '3.html'] 
      content.link = l
      content.save; content.reload
      content.link.should == ['foo.html', 'two.html', '3.html']
    end
  end

  context '#ordering' do
    it 'allows links to be ordered' do
      # TODO
    end
    it 'retains the ordering when loaded from db' do
      # TODO
    end
  end

end
