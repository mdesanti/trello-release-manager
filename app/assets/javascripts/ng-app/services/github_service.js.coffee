angular.module('TrelloRelease').service('GithubService', ['$rootScope', '$location', '$http', 'Restangular', 'GitHubRestangular', ($rootScope, $location, $http, Restangular, GitHubRestangular) ->

  service = {
    access_token: ''
    repos: []
    github: undefined
    login: (callback) ->
      OAuth.popup('github')
        .done((result) ->
            # Perform API calls
            service.access_token = result.access_token
            service.github = new Octokit({
              token: service.access_token
            })
            callback()
        )
        .fail((error) ->
            # Handle errors
            console.log 'Fail :('
        )
    loadUserRepos: (callback) ->
      service.github.getOrgRepos('Wolox').then(
        (response) ->
          callback(response)
      )
    getCommits: (repo, callback) ->
      service.github.getRepo('Wolox', repo.name).getBranch("production").getCommits({}).then((commits) ->
        callback(commits)
      )
    tagRelease: (repo, data) ->
      $http.defaults.headers.common.Authorization = 'token ' + service.access_token
      GitHubRestangular.all('repos/Wolox/' + repo.name + '/releases').post(data)
        .then(
          (response) ->
            console.log response.getList()
        )

    getReleases: (repo) ->
      $http.defaults.headers.common.Authorization = 'token ' + service.access_token
      GitHubRestangular.all('repos/Wolox/' + repo.name + '/releases').getList()
        .then(
          (response) ->
            console.log response.getList()
        )

  }
  return service;

]);
