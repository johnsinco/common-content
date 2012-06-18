module ContentsHelper

  def edit_for_type(type, name, *opts)
    render :partial => "views/contents/#{type}", opts
  end
end
