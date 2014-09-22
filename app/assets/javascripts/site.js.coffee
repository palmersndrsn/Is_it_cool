
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

# clear search bar
	$scope.clearSearch = ->
		$scope.query = ""

#clicking on event to see more

# adding a review to an event

	$scope.addReview = (newReview, index) ->
		$scope.rev = ""
		console.log newReview
		console.log index

# user signup
	$scope.signUp = (newUser) ->
		console.log newUser
		$http.post("/users.json", newUser).success (data) ->
			$scope.newUser = {}
			$scope.users = data
			console.log data

# new event
	$scope.newEvent = (event) ->
		console.log event
		$http.post("/events.json", event).success (data) ->
			$scope.event = {}
			$scope.events = data
			console.log data

#  event review button
	$scope.review = (eventId) ->
		console.log eventId
		# need to add logic for expanding event for user to review


	# limit height and have the events scroll


	# twitter api logic to search by hashtag and parse


	# need to add function for showing single event and map and hiding everything else
]

isItCool.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]