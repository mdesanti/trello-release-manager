angular.module('TrelloRelease')
  .controller('TagGithubRelaseCtrl', ['$scope', '$location', 'GithubService', ($scope, $location, GithubService) ->

    GithubService.authorize()

  ]);
