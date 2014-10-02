angular.module('TrelloRelease')
  .controller('TagGithubRelaseCtrl', ['$scope', '$location', 'GithubService', ($scope, $location, GithubService) ->

    $scope.repos = []

    $scope.$on('repos.update', (event) ->
      $scope.repos = GithubService.repos
      $scope.$apply()
    )

    $scope.login = () ->
      GithubService.login(() ->
        GithubService.loadUserRepos()
      )

    $scope.getCommits = (repo) ->
      GithubService.getCommits(repo)
  ]);
