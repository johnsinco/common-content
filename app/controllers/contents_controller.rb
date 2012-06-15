class ContentsController < ApplicationController

  def index
    @contents = Content.all_entries
  end
end
