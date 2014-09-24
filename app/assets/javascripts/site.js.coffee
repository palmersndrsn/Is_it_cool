
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
	$scope.authBox = false
	$scope.searchBox = true
	$scope.addEventBox = false
	$scope.signUpBtnNav = true



# INIT REVIEWS
	$scope.reviews = []
	$scope.review = {}
# AUTH

# log in user
	$scope.addSession = (loginUser) ->
		console.log "hi"
		console.log(loginUser)
		$http.post("/login.json", {user: loginUser}).success (user) ->
			$rootScope.current_user = user
			console.log user
			$scope.user = ""
			$scope.userActive(user)
			$scope.signInErr = true
		.error (err) ->
			$scope.signInErr = false

# checking if current user
	$scope.checkSesh = ->
		$http.get("/logged_in_user.json").success (user) ->
			console.log user
			$scope.userActive(user)

# hides/shows features if user is authenticated
	$scope.userActive = (user) ->
		$scope.activeUser = user
		$scope.authBox = false
		$scope.usernameNav = true
		$scope.logoutBtn = true
		$scope.eventBtnNav = true
		$scope.signUpBtnNav = false
		$scope.searchBox = true



	$scope.checkSesh()

	$scope.logout = ->
		$http.get("/logout.json").success ->
			console.log "signed out"
			$scope.logoutBtn = false
			$scope.eventBtnNav = false
			$scope.signUpBtnNav = true
			$scope.searchBox = true
			$scope.addEventBox = false
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

	# HIDE/SHOW BOXES
	$scope.showSearch = ->
		$scope.searchBox = true
		$scope.authBox = false
		$scope.addEventBox = false
		console.log "show Search"

	$scope.showAuthBox = ->
		$scope.authBox = true
		$scope.searchBox = false
		$scope.addEventBox = false
		console.log "show Auth"

	$scope.showAddEvent = ->
		$scope.addEventBox = true
		$scope.searchBox = false
		$scope.authBox = false
		console.log "show Event"

	# hide/show
	$scope.editEventShow = ->
		this.show_event_edit = true

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



]

isItCool.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]