xml.content do
  xml.name(content.slug)
  xml.link('rel' => 'self', 'uri' => content_path(content))
end