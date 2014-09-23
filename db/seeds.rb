# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# users

palmer = User.create({username: "dori_ps13",
  email: "palmer@gmail.com",
  password: "12341234"
})

the_dude = User.create({username: "the_dude",
	email: "elduderino@wheresmyrug.com",
	password: "12341234"})

rickybobby = User.create({username: "rickybobbydj",
	email: "rickybobbydj@aol.com",
	password: "12341234"})

user1 = User.create({username: "freespirit67",
	email: "freespirit67@aol.com",
	password: "12341234"})

user12 = User.create({username: "tim_jefferies",
	email: "tim@aol.com",
	password: "12341234"})

user123 = User.create({username: "katie45",
	email: "katie45@aol.com",
	password: "12341234"})

# events

lebwoski = Event.create({name: "Lebwoski Fest",
	desc: "The Dudes Abide",
	hashtag: "#LebwoskiFest",
	loc: "900 King Drive, Daily City CA"})

cochella = Event.create({name: "Cochella",
	desc: "Massive Music Festival",
	hashtag: "#cochella",
	loc: "81-800 Avenue 51, Indio, CA 92201"})

hiero = Event.create({name: "Hiero Day",
	desc: "Hieroglyphics Free Concert in Oakland",
	hashtag: "hieroday2014",
	loc: "95 Linden st, Oakland CA"})

rickybobbydj = Event.create({name: "Ricky Bobby's DJ Night",
	desc: "Hey you should come to my DJ night!",
	hashtag: "#rickydj",
	loc: "Some club you've never heard of"})

# reviews

cochellaReview1 = Review.create({body: "What hasn't been said about Cochella?",
	cool: "Yes",
	ratio: "50",
	grime: "70"
	})

cochellaReview2 = Review.create({body: "It used to be cool",
	cool: "No",
	ratio: "55",
	grime: "78"
	})

cochellaReview3 = Review.create({body: "I met the love of my life",
	cool: "Yes",
	ratio: "50",
	grime: "40"
	})

rbdj1 = Review.create({body: "This guy sucks",
	cool: "No",
	ratio: "80",
	grime: "54"
	})

LebwoskiFest1 = Review.create({body: "Yeah, well, you know, that's just, like, your opinion, man.",
	cool: "Yes",
	ratio: "80",
	grime: "70"
	})

LebwoskiFest2 = Review.create({body: " It's good knowin' he's out there. The Dude. Takin' 'er easy for all us sinners. Shoosh. I sure hope he makes the finals.",
	cool: "Yes",
	ratio: "82",
	grime: "62"
	})

hierodayreview1 = Review.create({body: "It's smokey, it's a little dirty, it's Oakland and it's awesome",
	cool: "Yes",
	ratio: "55",
	grime: "70"
	})



# relationships
# reviews users

user1.reviews << cochellaReview3

palmer.reviews << rbdj1

user12.reviews << cochellaReview2

user12.reviews << LebwoskiFest2

user123.reviews << hierodayreview1

user123.reviews << cochellaReview1

palmer.reviews << LebwoskiFest1





# reviews events

hiero.reviews << hierodayreview1

lebwoski.reviews << LebwoskiFest1

lebwoski.reviews << LebwoskiFest2

rickybobbydj.reviews << rbdj1

cochella.reviews << cochellaReview1

cochella.reviews << cochellaReview2

cochella.reviews << cochellaReview3

# events

rickybobby.events << rickybobbydj

the_dude.events << lebwoski

palmer.events << cochella

palmer.events << hiero
