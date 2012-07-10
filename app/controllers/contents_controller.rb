class ContentsController < ApplicationController

  respond_to :html, :json, :xml

  before_filter :customize_view_paths

  # helper_method :link_to_add_fields

  def index
    @contents = Content.all
    respond_with @contents
  end

  def new
    @content = Content.new
  end

  def edit
    @content = Content.find_by_ancestry(params[:ancestors].try(:split,'/'), params[:id]) 
    # @content.build_seo unless @content.seo
    # @content.child_contents.create(slug:"#{@content.slug}-kid-#{@content.child_contents.count}", title:"#{@content.slug} Kid") if @content.child_contents.size == 0
    respond_with @content
  end

  def define 
    @content = Content.find(params[:id])
  end

  def show    # Content.all_entries
    @content = Content.find_by_ancestry(params[:ancestors].try(:split,'/'), params[:id])
    respond_with @content
  end


  def create
    @content = Content.new(params[:content])
    if @content.save
      # respond_with @content
      redirect_to contents_path, notice: "#{@content.slug} created."
    else
      format.html { render action: "new" }
      format.json { render json: @content.errors, status: :unprocessable_entity }
    end
  end

  def update
    @content = Content.find_by_ancestry(params[:ancestors].try(:split,'/'), params[:id])
    if @content.update_attributes(params[:content])
      redirect_to contents_path, notice: "#{@content.title} updated."
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end


  # TODO add code here to build-up embedded objects in the edited object via ajax
  def modify
    @content = Content.find(params[:id])

  end


  # PUT /foos/1
  # PUT /foos/1.json
  def renovate
    @content = Content.find(params[:id])
    @content.renovate(params[:content][:defn])
    if @content.save
      redirect_to contents_path, notice: "#{@content.slug} definition updated."
    else
      respond_to do |format|
        format.html { render action: "define" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @content = Content.find_by_ancestry(params[:ancestors].try(:split,'/'), params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to contents_url}
      format.json { head :no_content }
    end

  end

  def customize_view_paths 
    c = Content.find_by_ancestry(params[:ancestors].try(:split, '/'), params[:id]) if params[:id]
    prepend_view_path "app/views/contents/#{c.slug}" if c
  end

end
