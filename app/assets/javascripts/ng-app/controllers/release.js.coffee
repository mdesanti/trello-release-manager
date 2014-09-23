angular.module('TrelloRelease')
  .controller('ReleaseCtrl', ($scope, $routeParams, $location, ReleaseService) ->

    $scope.info = {to: [""]}

    $scope.$on('release.update', (event) ->
      $scope.release = ReleaseService.release
      $scope.info.trello_release = $scope.release.id
    )
    ReleaseService.getRelease($routeParams.releaseId)

    $scope.submit = () ->
      ReleaseService.sendEmail($scope.info)
      $location.path('/')

    $scope.addNewEmail = () ->
      $scope.info.to.push("")

  );
