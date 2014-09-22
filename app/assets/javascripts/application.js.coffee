# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# // or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // compiled file.
# //
# // Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# // about supported directives.
# //
# //= require jquery
# //= require jquery_ujs
# //= require turbolinks
# //= require twitter/bootstrap
# //= require loadjs
# //= require_tree .

load "home#index", (controller, action) ->

  token = ''

  authenticateTrello = ->
    Trello.authorize({
      name: "Trello Release",
      type: "popup",
      interactive: true,
      expiration: "never",
      persist: true,
      success:  ->
        onAuthorizeSuccessful()
      scope: { write: false, read: true },
    });


  onAuthorizeSuccessful = ->
    token = Trello.token()

  displayListTitle = (list) ->
    $('#list-name').append('<h1>' + list.name + '</h1>')

  enableDeleteCard = ->
    delete_crosses = $('.delete-card')
    $.each(delete_crosses, (index, value) ->
      $(value).click( () ->
        $(value).parent().parent().parent().remove()
      )
    )

  searchForLatestList = (data) ->
    latest = undefined
    latest_list = undefined
    $.each(data, (index, value) ->
      if value.name.toLowerCase().indexOf('production') >= 0
        date = new Date(value.name.split(" ")[1])
        if latest == undefined || latest.getTime() > date.getTime()
          latest = date
          latest_list = value
    )
    displayListTitle(latest_list)
    getCardsForList(latest_list.id)

  getLatestList = (board_id) ->
    Trello.get('/boards/' + board_id + '/lists',
      (data) ->
        searchForLatestList(data)
      (data) ->
        console.log 'Failure :('
    )

  buildCardHtml = (card, index) ->
    '<input type="hidden" name="trello_release[trello_cards_attributes][][card_number]" value="' + card.idShort + '">
     <input type="hidden" name="trello_release[trello_cards_attributes][][card_name]" value="' + card.name + '">
     <input type="hidden" name="trello_release[trello_cards_attributes][][card_link]" value="' + card.url + '">
     <div class="col-md-4 card">
      <div class="panel panel-primary panel-title">
        <div class="panel-heading">
          <span class="glyphicon glyphicon-remove delete-card"/>
          <a href="' + card.url + '" target="_blank"> <h3 class="panel-title">#' + card.idShort + '</h3></a>
        </div>
        <div class="panel-body">
          <p class="list-group-item-text">' + card.name + '</p>
        </div>
      </div>
    </div>'


  showCards = (cards) ->
    list = $('#cards')
    $.each(cards, (index, value) ->
      list.append(buildCardHtml(value, index))
    )
    enableDeleteCard()
    $('#form').removeClass('hidden')

  getCardsForList = (list_id) ->
    Trello.get('/lists/' + list_id + '/cards',
      (data) ->
        showCards(data)
      (data) ->
        console.log 'Failure :('
    )

  showBoard = (data) ->
    $('#boards-list').append('<a href="#" data-board_id="' + data.id + '" class="list-group-item">' + data.name + '</a>')

  setOnClick = (board_id) ->
    $('#boards-list :last-child').click( ->
      $('#boards-list').css('hidden')
      getLatestList(board_id)
    )

  listBoards = (data) ->
    $.each(data.idBoards, (index, value) ->
      Trello.get('/boards/' + value,
        (data) ->
          showBoard(data)
          setOnClick(data.id)
        (data) ->
          console.log data
      )
    )

  getAndListBoards = () ->
    Trello.members.get(
      'me',
      (data) ->
        listBoards(data)
      (data) ->
        console.log data
    )


  authenticateTrello()
  getAndListBoards()

