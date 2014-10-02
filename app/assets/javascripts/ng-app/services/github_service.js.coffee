angular.module('TrelloRelease').service( 'GithubService', [ '$rootScope', '$location', 'Restangular', ($rootScope, $location, Restangular) ->

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
    loadUserRepos: () ->
      service.github.getOrgRepos('Wolox').then(
        (response) ->
          service.repos = response
          $rootScope.$broadcast('repos.update');
      )
    getCommits: (repo) ->
      service.github.getRepo('Wolox', repo.name).getCommits({}).then((commits) ->
        console.log commits
      )
  }
  return service;
]) ;
