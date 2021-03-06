module ContentsHelper
  def hateoas_uri_options(source, entity)
    # open the source url
    # parse out the entities
    # look for <name> and <link rel='self'> and parse into [[link, name]]   
  end


  # from http://railscasts.com/episodes/196-nested-model-form-revised?view=asciicast

  def link_to_add_fields(name, f, association, enclosing_element = nil)
    begin
      new_object = f.object.send(association).klass.new
    rescue Exception => e
      p e
    end
    new_object ||= ::Content.const_get(association.to_s.camelize).new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial: "#{association.to_s.singularize}_fields", locals: { f: builder, child_index: id })
    end
    link_to(name, '#', class: "add_fields add_#{association}", 
              data: {id: id, fields: fields.gsub("\n", ""), enclosing: enclosing_element})
  end

  def resource_edit_view(resource_type = nil, f)
    if lookup_context.exists?(resource_type, 'contents', true)
      render partial:  resource_type, locals: {f: f}
    else
      render partial: 'resource_edit_fields', locals: {f: f}
    end
  end
end
