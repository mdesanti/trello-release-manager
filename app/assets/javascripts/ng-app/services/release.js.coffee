angular.module('TrelloRelease').service( 'ReleaseService', [ '$rootScope', 'Restangular', ($rootScope, Restangular) ->
  service = {
    release: '',
    newRelease: (cards) ->
      data = {trello_release: {release_date: new Date(), trello_cards_attributes: ''} }
      data['trello_release']['trello_cards_attributes'] = serializeCards(cards)
      base = Restangular.all('trello_releases.json')
      base.post(data).then(
        (response) ->
          return response.id
        () ->
          console.log 'Failure :('
      )
    getRelease: (release_id) ->
      release = Restangular.one('trello_releases/' + release_id + '.json')
      release.get().then(
        (response) ->
          service.release = angular.fromJson(response.trello_release)
          $rootScope.$broadcast('release.update');
        () ->
          console.log 'Failure'
      )
    sendEmail: (info) ->
      base = Restangular.all('send_email.json')
      base.post(info)
  }

  serializeCards = (cards) ->
    serialized = []
    angular.forEach(cards, (card, index) ->
      serialized.push({card_number: card.idShort, card_link: card.url, card_name: card.name} ) ;
    )
    return serialized

  return service;
]) ;
