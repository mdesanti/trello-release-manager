angular.module('TrelloRelease').service( 'ReleaseService', [ '$rootScope', 'Restangular', ($rootScope, Restangular) ->
  service = {
    release: '',
    newRelease: (release) ->
      base = Restangular.all('trello_releases.json')
      base.post({trello_release: release}).then(
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
