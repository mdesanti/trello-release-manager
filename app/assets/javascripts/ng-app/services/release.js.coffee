angular.module('TrelloRelease').service( 'ReleaseService', [ '$rootScope', 'Restangular', ($rootScope, Restangular) ->
  service = {
    release: '',
    boardReleases: [];
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
    getReleaseForBoard: (board) ->
      release = Restangular.one('trello_releases/for_board.json')
      release.get({board_id: board.id}).then(
        (response) ->
          service.boardReleases = angular.fromJson(response.trello_releases)
          $rootScope.$broadcast('boardReleases.update');
        () ->
          console.log 'Failure'
      )
    sendEmail: (info) ->
      base = Restangular.all('send_email.json')
      base.post(info)
  }
  return service;
]) ;
