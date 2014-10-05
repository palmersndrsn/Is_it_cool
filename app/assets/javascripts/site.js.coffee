
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
		$http.get("/logged_in_user.json").success (data) =>
			$rootScope.current_user = user
]

isItCool.controller "siteCtrl", ["$scope", "$http", "$rootScope", "$location", ($scope, $http, $rootScope, $location) ->

# need logic for hiding add post and sign in
	# should check for current user
# FLASH MESSAGES OFF
	$scope.show_sign_in = true
	$scope.signUpBtnNav = true
	$scope.addEventBox = false
	$scope.signInErr = true
	$scope.signUpErr = true
	$scope.searchBox = true
	$scope.eventErr = true
	$scope.authBox = false





# INIT REVIEWS
	$scope.reviews = []
	$scope.review = {}
# AUTH

# log in user
	$scope.addSession = (loginUser) ->
		$http.post("/login.json", {user: loginUser}).success (user) ->
			$rootScope.current_user = user
			$scope.user = ""
			$scope.userActive(user)
			$scope.signInErr = true
		.error (err) ->
			$scope.signInErr = false

# checking if current user
	$scope.checkSesh = ->
		$http.get("/logged_in_user.json").success (user) ->
			$rootScope.current_user = user
			$scope.userActive(user)

# hides/shows features if user is authenticated
	$scope.userActive = (user) ->
		$scope.activeUser = user
		$scope.signUpBtnNav = false
		$scope.usernameNav = true
		$scope.eventBtnNav = true
		$scope.logoutBtn = true
		$scope.searchBox = true
		$scope.authBox = false



	$scope.checkSesh()

	$scope.logout = ->
		$http.get("/logout.json").success ->
			$scope.signUpBtnNav = true
			$scope.eventBtnNav = false
			$scope.addEventBox = false
			$scope.usernameNav = false
			$scope.logoutBtn = false
			$scope.searchBox = true

# SEARCH
	$scope.clearSearch = =>
		$scope.query = ""

# REVIEWS

  # get reviews
	$scope.getReviews = (event) ->
		# $scope.show_reviews = true
		this.show_reviews = true
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
		$http.post("/users.json", {user: newUser}).success (data) =>
			$scope.newUser = {}
			$scope.users = data
			$scope.signUpErr = true
			$scope.show_sign_up = false
			$scope.show_sign_in = true
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
		$http.post("/events.json", event).success (data) =>
			$scope.event = ""
			$scope.events.push data
			$scope.eventErr = true
		.error (err) ->
			$scope.eventErr = false


	# edit event
	$scope.editEvent = (event, index) ->
		this.show_event_edit = true
		$http.put("/events/" + index + ".json", event).success (data) =>
			this.event = data
			this.show_event_edit = false


	# delete event
	$scope.deleteEvent = (id, index) ->
		$http.delete("/events/" + id + ".json").success (data) =>
			$scope.events.splice(index,1)


	# HIDE/SHOW BOXES
	$scope.showSearch = ->
		$scope.searchBox = true
		$scope.authBox = false
		$scope.addEventBox = false

	$scope.showAuthBox = ->
		$scope.authBox = true
		$scope.searchBox = false
		$scope.addEventBox = false

	$scope.showAddEvent = ->
		$scope.addEventBox = true
		$scope.searchBox = false
		$scope.authBox = false

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