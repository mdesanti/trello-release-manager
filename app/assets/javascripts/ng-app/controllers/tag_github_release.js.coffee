angular.module('TrelloRelease')
  .controller('TagGithubRelaseCtrl', ['$scope', '$location', '$routeParams', 'ReleaseService', 'GithubService', ($scope, $location, $routeParams, ReleaseService, GithubService) ->

    $scope.data = {}
    $scope.data.body = ''
    $scope.data.draft = false

    $scope.$on('release.update', (event) ->
      $scope.release = ReleaseService.release
      buildBody(ReleaseService.release)
    )
    ReleaseService.getRelease($routeParams.releaseId)

    $scope.login = () ->
      GithubService.login(() ->
        GithubService.loadUserRepos(onReposLoaded)
      )

    onReposLoaded = (repos) ->
      $scope.repos = repos
      $scope.$apply()

    $scope.getBranches = (repo) ->
      GithubService.getBranches(repo, (branches) ->
        $scope.branches = branches
        $scope.$apply()
      )

    $scope.getCommits = (repo) ->
      GithubService.getReleases(repo)
      $scope.selectedRepo = repo
      GithubService.getCommits(repo, (commits) ->
        $scope.commits = commits
        $scope.$apply()
      )

    $scope.selectCommit = (commit) ->
      $scope.selectedCommit = commit
      $scope.data.target_commitish = commit.sha

    buildBody = (release) ->
      body = ''
      angular.forEach(release.trello_cards, (card, index) ->
        body += '- [' + card.card_number + '](' + card.card_link + ') ' + card.card_name + '\r\n'
      )
      $scope.data.body = body

    $scope.tagRelease = () ->
      GithubService.tagRelease($scope.selectedRepo, $scope.data)
  ]);
