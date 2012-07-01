require 'spec_helper'

describe ContentsController do
  context '#index' do
    it 'returns a list of contents' do 
      get :index
      assigns(:contents).should be
    end
  end
  context '#edit' do
    before { Content.create!(slug:'foo',title:'foo') }
    it 'returns the content instance' do
      c = Content.first
      get :edit, id: c.id
      assigns(:content).should == c
    end
    it 'can update the fields in content' do
      get :edit, id: Content.first.id
      c = assigns(:content)
      c.title.should == 'foo'
      c.title = 'updated'
      put :update, id: c.id, content: c
      Content.find(c.id).title.should == 'updated'
    end
    it 'can update the fields in the embedded SEO document' do
    end
  end
  context '#create' do
  end
  context '#renovate' do
  end
  context '#update' do
  end
end