
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

	$scope.reviews = []
	$scope.review = {}


# SEARCH
	$scope.clearSearch = =>
		$scope.query = ""

# REVIEWS

  # get reviews
	$scope.getReviews = (event) ->
		# $scope.show_reviews = true
		this.show_reviews = true
		console.log $scope.collapse1
		$http.get("/events/" + event.id + "/reviews.json").success (data) ->
			$scope.reviews = data

# adding a review to an event
	$scope.addReview = (review, index) ->
		review.event_id = index
		$http.post("/events/" + index + "/reviews.json", {review: review}).success (data) ->
			$scope.reviews.push data
			$scope.review = {}
			$scope.show_review_form = false


# SIGNUP
# user signup
	$scope.signUp = (newUser) ->
		console.log newUser
		$http.post("/users.json", {user: newUser}).success (data) =>
			$scope.user = {}
			$scope.users = data
			console.log data

# EVENTS

# get all events
	$scope.getEvents = ->
		$http.get("/events.json").success (data) ->
			$scope.events = data

	$scope.getEvents()

# new event
	$scope.newEvent = (event) ->
		console.log event
		$http.post("/events.json", event).success (data) =>
			$scope.event = {}
			$scope.events = data
			console.log data


	# edit event
	$scope.editEvent = (event, index) ->
		this.show_event_edit = true
		console.log $scope.review
		console.log index
		$http.put("/events/" + index + ".json", event).success (data) =>
			console.log data
			this.event = data
			this.show_event_edit = false


	# delete event
	$scope.deleteEvent = (id, index) ->
		console.log index
		$http.delete("/events/" + id + ".json").success (data) =>
			$scope.events.splice(index,1)
			console.log data




#  event review butt
		# need to add logic for expanding event for user to review


	# limit height and have the events scroll


	# twitter api logic to search by hashtag and parse


	# need to add function for showing single event and map and hiding everything else



	$scope.showReviewForm =->
		$scope.show_review_form = true

	# edit review
	$scope.editReview = ->
		console.log $scope.review


	# delete review
	$scope.deleteReview = ->
		console.log $scope.review


]

isItCool.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]