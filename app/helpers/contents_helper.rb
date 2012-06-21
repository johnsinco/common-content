module ContentsHelper
  def hateoas_uri_options(source, entity)
    # open the source url
    # parse out the entities
    # look for <name> and <link rel='self'> and parse into [[link, name]]   
  end

  def edit_for_type(type, name, *opts)
    render :partial => "views/contents/#{type}", opts
  end
end
