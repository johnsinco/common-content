class ContentsController < ApplicationController

  respond_to :html, :json

  def index
    @contents = Content.all_entries
    respond_with @contents
  end

  def new
    @content = Content.new
    @content.build_definition(definition:'')
    @content
  end

  def edit
    # Content.all_entries
    @content = Content.find(params[:id])
  end

  def define 
    Content.all_entries
    @content = Content.find(params[:id])
  end

  def show    # Content.all_entries
    Content.all_entries
    @content = Content.find(params[:id])
  end


  def create
    @content = Content.build(params[:content][:slug], params[:content][:defn])
    if @content.save
      # respond_with @content
      redirect_to contents_path, notice: "#{@content.slug} created."
    else
      format.html { render action: "new" }
      format.json { render json: @content.errors, status: :unprocessable_entity }
    end
  end

  # PUT /foos/1
  # PUT /foos/1.json
  def renovate
    @content = Content.find(params[:id])
    @content.renovate(params[:content][:defn])
    if @content.save
      respond_with @content
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @foo.errors, status: :unprocessable_entity }
      end
    end
  end

end
