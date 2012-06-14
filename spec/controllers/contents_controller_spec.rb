require 'spec_helper'

describe ContentsController do
  context '#index' do
    it 'returns a list of contents' do 
      get :index
      assigns(:contents).should be
    end
  end
end