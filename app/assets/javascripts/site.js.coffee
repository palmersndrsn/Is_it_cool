
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

isItCool.controller "MainCtrl", ["$scope", "$http", "$rootScope", ($scope, $http, $rootScope) ->
	if !$scope.current_user
		console.log("checking for current_user")
		$http.get("/logged_in_user.json").success (data) =>
			console.log "Welcome,", user
			$rootScope.current_user = user
]

isItCool.controller "siteCtrl", ["$scope", "$http", "$rootScope", "$location", ($scope, $http, $rootScope, $location) ->

# need logic for hiding add post and sign in
	# should check for current user
# FLASH MESSAGES OFF
	$scope.show_sign_in = true
	$scope.signInErr = true
	$scope.signUpErr = true
	$scope.eventErr = true


# INIT REVIEWS
	$scope.reviews = []
	$scope.review = {}
# AUTH

	$scope.addSession = (loginUser) ->
		console.log "hi"
		console.log(loginUser)
		$http.post("/login.json", {user: loginUser}).success (user) ->
			$rootScope.current_user = user
			console.log user
			$scope.user = ""
			# need to build this up
			$scope.showAddEvent()
			$scope.sessionActive(user)
			# this is when the user is logged in
			$scope.signInErr = true
		.error (err) ->
			$scope.signInErr = false


	$scope.sessionActive = (user) ->




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
			$scope.review = ""


# SIGNUP
# user signup
	$scope.signUp = (newUser) ->
		console.log newUser
		$http.post("/users.json", {user: newUser}).success (data) =>
			$scope.newUser = {}
			$scope.users = data
			console.log data
			$scope.signUpErr = true
		.error (err) ->
			$scope.signUpErr = false


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
			$scope.event = ""
			$scope.events.push data
			console.log data
			$scope.eventErr = true
		.error (err) ->
			$scope.eventErr = false


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

	# hide/show

	$scope.hideReviews = ->
		this.show_reviews = false

	$scope.showReviewForm = ->
		$scope.show_review_form = true

	$scope.showSignUp = ->
		$scope.show_sign_up = true
		$scope.show_sign_in = false

	$scope.showSignIn = ->
		$scope.show_sign_up = false
		$scope.show_sign_in = true

	$scope.showAddEvent = ->
		$scope.show_sign_up = false
		$scope.show_sign_in = false


]

isItCool.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]