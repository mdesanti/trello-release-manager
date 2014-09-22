load "trello_releases#show", (controller, action) ->
  $('#add-email').click( ->
    $('#to').append(
      '<div class="input-group" id="to">
        <span class="input-group-addon">@</span>
        <input class="form-control" id="to_" name="to[]" placeholder="to" type="email" value="">
      </div>'
    )
  )
