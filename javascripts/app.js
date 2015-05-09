var app = angular.module('ghPages', [
    'ngRoute'
]);

app.config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.when('/', {
                templateUrl: 'partials/index.html',
                controller: 'MainCtrl'
            }
        ).when('/hours', {
                templateUrl: 'partials/hours.html',
                controller: 'MainCtrl'
            }
        ).when('/docs', {
                templateUrl: 'partials/docs.html',
                controller: 'MainCtrl'
            }
        ).otherwise({
                redirectTo: '/'
            }
        );
    }
]);

app.controller('MainCtrl', function ($scope) {
    $scope.hours = [
        [
            {
                date: '09.03.2015',
                hours: 4
            },
            {
                date: '10.03.2015',
                hours: 3
            },
            {
                date: '11.03.2015',
                hours: 4
            },
            {
                date: '14.03.2015',
                hours: 2
            },
            {
                date: '18.03.2015',
                hours: 2.5
            },
            {
                date: '21.03.2015',
                hours: 2.5
            },
            {
                date: '23.03.2015',
                hours: 4
            },
            {
                date: '31.03.2015',
                hours: 2.75
            }
        ], [
            {
                date: '02.04.2015',
                hours: 1.5
            },
            {
                date: '19.04.2015',
                hours: 3.5
            },
            {
                date: '22.04.2015',
                hours: 2
            },
            {
                date: '25.04.2015',
                hours: 0.5
            },
            {
                date: '26.04.2015',
                hours: 3.5
            },
            {
                date: '27.04.2015',
                hours: 6.75
            }
        ], [
            {
                date: '08.05.2015',
                hours: 1.15
            },
            {
                date: '09.05.2015',
                hours: 3
            }
        ]
    ]
});
