xml.contents do
  @contents.each do |c|
    xml << render(:partial => 'content.xml.builder', object: c)
  end
end