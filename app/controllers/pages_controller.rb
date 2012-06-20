class PagesController < ApplicationController
  respond_to :html, :json

  def index
    @pages = Page.all
    respond_with @pages
  end
  def edit
    @page = Page.find(params[:id])
    respond_with @page
  end
  def new
    @page = Page.new
    respond_with @page
  end

  def edit
    @page = Page.find(params[:id])
    respond_with @page
  end
  def show 
    @page = Page.find(params[:id])
    respond_with @page
  end

   def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: "Created #{@page.title}"}
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: "Updated #{@page.title}." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

end
