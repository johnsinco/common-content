jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $($(this).data('enclosing')).prepend($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'change', '.select_resource_type', (event) ->
    $(this).parents('.control-group').prepend($(this).children('option:selected').data('content'))

  $('#children').sortable({ items: '.embedded-child'})  
  $('#resources').sortable({ items: 'div.resource'})  

  $('form').on 'submit', (event) ->
    $("#content_child_order").val($("#children").sortable('toArray'))
    $("#content_resource_order").val($("#resources").sortable('toArray'))
