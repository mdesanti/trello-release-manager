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
            service.github = new Github({
              token: service.access_token,
              auth: "oauth"
            });
            callback()
        )
        .fail((error) ->
            # Handle errors
            console.log error
        )
    loadUserRepos: (callback) ->
      service.github.getUser().orgRepos('Wolox',
        (err, response) ->
          callback(response)
      )
    getBranches: (repo, callback) ->
      service.github.getRepo('Wolox', repo.name).listBranches((err, branches) ->
        callback(branches)
      )
    getCommits: (repo, branch, callback) ->
      service.github.getRepo('Wolox', repo.name).getCommits({sha: branch, author: 'mdesanti'}, (err, commits) ->
        callback(err, commits)
      )
    tagRelease: (repo, data, callback) ->
      $http.defaults.headers.common.Authorization = 'token ' + service.access_token
      GitHubRestangular.all('repos/Wolox/' + repo.name + '/releases').post(data)
        .then(
          (response) ->
            callback(response)
        )

  }
  return service;

]);
