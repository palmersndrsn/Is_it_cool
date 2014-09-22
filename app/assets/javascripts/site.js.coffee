
isItCool = angular.module "isItCool", ["ngRoute", "templates"]

isItCool.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when "/",
			templateUrl: "index.html",
			controller: "siteCtrl"
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true)

]

isItCool.controller "siteCtrl", ["$scope", "$http", ($scope, $http) ->
# get all events
	$scope.getEvents = ->
		$http.get("/events.json").success (data) ->
			$scope.events = data


	$scope.getEvents()
# user signup
	$scope.signUp = (newUser) ->
		console.log newUser
		$http.post("/users.json", newUser).success (data) ->
			$scope.newUser = {}
			$scope.users = data
			console.log data

	$scope.search = (searchVal) ->
		console.log searchVal

# new event
	$scope.newEvent = (event) ->
		console.log event
		$http.post("/events.json", event).success (data) ->
			$scope.event = {}
			$scope.events = data
			console.log data


]

isItCool.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]