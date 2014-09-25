angular.module('TrelloRelease')
  .controller('ListReleasesCtrl', ['$scope', '$location', 'ReleaseService', 'TrelloService', ($scope, $location, ReleaseService, TrelloService) ->

    $scope.boardReleases = [];

    $scope.$on('boardReleases.update', (event) ->
      $scope.boardReleases = ReleaseService.boardReleases
      $scope.$$phase || $scope.$apply()
    )

    ReleaseService.getReleaseForBoard(TrelloService.selectedBoard)

    $scope.submit = () ->
      ReleaseService.sendEmail($scope.info)
      $location.path('/')

    $scope.addNewEmail = () ->
      $scope.info.to.push("")

  ]);
