angular.module('TrelloRelease')
  .controller('TagGithubRelaseCtrl', ['$scope', '$location', '$routeParams', 'ReleaseService', 'GithubService', ($scope, $location, $routeParams, ReleaseService, GithubService) ->

    $scope.data = {}
    $scope.data.body = ''
    $scope.data.draft = false
    $scope.releaseTagged = false
    $scope.loggedIn = false
    $scope.step = 1

    $scope.$on('release.update', (event) ->
      $scope.release = ReleaseService.release
      buildBody(ReleaseService.release)
    )
    ReleaseService.getRelease($routeParams.releaseId)

    $scope.login = () ->
      GithubService.login(() ->
        GithubService.loadUserRepos(onReposLoaded)
        $scope.loggedIn = true
        $scope.$apply()
      )

    onReposLoaded = (repos) ->
      $scope.repos = repos
      $scope.$apply()

    $scope.getBranches = (repo) ->
      $scope.selectedRepo = repo
      GithubService.getBranches(repo, (branches) ->
        $scope.step = 2
        $scope.branches = branches
        $scope.$apply()
      )

    $scope.getCommits = (repo, branch) ->
      $scope.commits = []
      GithubService.getCommits(repo, branch, (err, commits) ->
        $scope.step = 3
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
      GithubService.tagRelease($scope.selectedRepo, $scope.data, onReleaseTagged)

    onReleaseTagged = (response) ->
      $scope.releaseTagged = true
      $scope.githubRelease = response
      console.log response
  ]);
