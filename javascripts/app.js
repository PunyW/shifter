var app = angular.module('ghPages', [
    'ngRoute'
]);

app.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.when('/', {
                templateUrl: 'partials/index.html',
                controller: 'MainCtrl'
            }
        ).when('/hours', {
                templateUrl: 'partials/hours.html',
                controller: 'MainCtrl'
            }
        )
    }
]);

app.controller('MainCtrl', function($scope) {

});