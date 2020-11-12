require 'pry'
require 'rest-client' # in order to make HTTP requests from a ruby file
require 'json'

# Category.destroy_all
# User.destroy_all
# Game.destroy_all

# # AI: Seed with 100 categories from the API 
# api_resp = RestClient.get("http://jservice.io/api/categories?count=100")
# api_data = JSON.parse(api_resp)

# api_data.each { |cat| Category.create( api_id: cat["id"], title: cat["title"] )}
# # Category.create(api_data) NOT GONNA WORK B/C ADNTL KEY FROM API 

# # binding.pry

# User.create(username: "Caryn", password: "12345")




Movie.destroy_all
Review.destroy_all
User.destroy_all
Movielist.destroy_all
# AddMovieToMovielist.destroy_all

# Movie.create(title: 'Deep Red', director: 'Dario Argento', year: 1975, genre: 'Horror', country: 'Italy', synopsis: 'A pianist investigates a series of murders performed by a mysterious figure wearing black leather gloves.')
# Movie.create(title: 'Phantom of the Paradise', director: 'Brian de Palma', year: 1974, genre: 'Horror', country: 'USA', synopsis: 'A pianists lifes work is stolen by a record tycoon, and he murders everyone who plays it.')
# Movie.create(title: 'Saving Private Ryan', director:  'Steven Spielberg', year: 1998, genre: 'Action', country:  'USA', synopsis: 'saving ryan from the war')
# Movie.create(title: 'Titanic', director: 'James Cameron', year: 1997, genre: 'Drama', country: 'USA', synopsis: 'boat goes down...')


# User.create(name: 'Aaron')
# User.create(name: 'Julio')

# Review.create(user_id: u1, movie_id: m1, rating: 3)


Movie.create([
    {title: 'Deep Red', director: 'Dario Argento', year: 1975, genre: 'Horror', country: 'Italy', synopsis: 'A pianist investigates a series of murders performed by a mysterious figure wearing black leather gloves.'},
    {title: 'Phantom of the Paradise', director: 'Brian de Palma', year: 1974, genre: 'Horror', country: 'USA', synopsis: 'A pianists lifes work is stolen by a record tycoon, and he murders everyone who plays it.'},
    {title: 'Saving Private Ryan', director:  'Steven Spielberg', year: 1998, genre: 'Action', country:  'USA', synopsis: 'saving ryan from the war'},
    {title: 'Titanic', director: 'James Cameron', year: 1997, genre: 'Drama', country: 'USA', synopsis: 'boat goes down...'},
    {title: 'Avatar', director: 'James Cameron', year: 2009, genre: 'Science Fiction', country: 'USA', synopsis: 'Humans and avatars meet in the alien World od Pandora'},
    {title: '7 Pounds', director: 'Gabriele Muchino', year: 2008, genre: 'Drama', country: 'USA', synopsis: 'A man wh wants to donate his organs'},
    {title: 'Elite Squad', director: 'Jose Padilha', year: 2008, genre: 'Action', country: 'Brazil', synopsis: 'Elite police squad enters the poorest slums'},
    {title: 'Interstellar', director: 'Christopher Nolan', year: 2014, genre: 'Science Fiction', country: 'USA', synopsis: 'A brilliant NASA physicists finds a way to safe mankind'},
    {title: 'The SpongeBob Movie', director: 'Tim Hill', year: 2020, genre: 'Cartoon', country: 'USA', synopsis: 'SpongeBob goes on wild adventures'},
    {title: 'The Godfather', director: 'Francis Ford Coppola', year: 1972, genre: 'Mafia', country: 'USA', synopsis: 'The GodFather is made!!!'}
    # {title: '', director: '', year: , genre: '', country: '', synopsis: ''}

])


User.create([
    {name: 'a', password: 'a'},
    {name: 'Julio', password: 'fizz'},
    {name: 'Jonathan', password: 'buzz'},
    {name: 'Anber', password: 'fizzbuzz'},
    {name: 'Melissa', password: 'wordpass'},
    {name: 'Aaron', password: 'password'}
])

m1 = Movie.first
m2 = Movie.second
m3 = Movie.third
m4 = Movie.fourth
m5 = Moview.fifth
# m6 = Movie.

u1 = User.first
u2 = User.second
u3 = User.third
u4 = User.fourth
u5 = User.fifth



Review.create([
    {user: u1, movie: m1, rating: 3},
    {user: u1, movie: m2, rating: 2},
    {user: u1, movie: m3, rating: 5},
    {user: u1, movie: m4, rating: 1},
    {user_id: u2.id, movie_id: m2.id , rating: 5},

    # {user_id: , movie_id: , rating: },
    # {user_id: , movie_id: , rating: }
])

# r1 = Review.first
# r2 = Review.second

# Movielist.create([
#     {user: u1},
#     {user: u2},
#     {user: u3},
#     {user: u4},
#     {user: u5}
# ])

# ml1 = Movielist.first
# ml2 = Movielist.second
# ml3 = Movielist.third
# ml4 = Movielist.fourth
# ml5 = Movielist.fifth

# Addmovietomovielist.create([
#     {movie: Movie.all.sample, movielist: Movielist.all.sample, priority: 1},
#     {movie: m2, movielist: ml5, priority: 2},
#     {movie: m3, movielist: ml1, priority: 3}
# ])

  
# Driver.destroy_all
# Passenger.destroy_all
# Ride.destroy_all
# # 1. Dummy data 
# # 2. Starter data for your application 

# # one way to create an instances
# vik = Driver.create(name: "Vik", age: 60, experience: 450, points: 0, car: "berlinetta")

# # another way to create instances
# Driver.create([
#     {name: "Pedro IV", age: 70, experience: 20, points: 6, car: "red rivian"},
#     {name: "Raffy", age: 10, experience: 100, points: 0, car: "mustang"},
#     {name: "Jason", age: 43, experience: 999999, points: 4, car: "bmw"},
#     {name: "Julio", age: 29, experience: 200, points: 0, car: "tesla"},
#     {name: "Serkan", age: 39, experience: 400, points: 1, car: "ferrari"},
#     {name: "Amelia", age: 49, experience: 200, points: 0, car: "Mercedes-Benz"},
#     {name: "Shannon", age: 59, experience: 200, points: 0, car: "tesla"},
#     {name: "Kelsea", age: 19, experience: 50, points: 3, car: "bmw"},
#     {name: "Tommy", age: 25, experience: 70, points: 1, car: "mustang"}
# ])

# d1 = Driver.first
# d2 = Driver.second
# d3 = Driver.last

# Passenger.create([
#     {name: "Sara", bio: " Pudding jelly-o soufflé candy dessert lollipop. ", rating: 4.7},
#     {name: "Anber", bio: "Pudding tiramisu lemon drops cake bonbon.", rating: 4.95},
#     {name: "Anthony", bio: "Wafer tart jujubes fruitcake ice cream carrot cake cookie tiramisu.", rating: 3.2},
#     {name: "JC", bio: "Pudding tiramisu lemon", rating: 2.9}, 
#     {name: "Serkan", bio: "Wafer tart jujubes fruitcake ice cream carrot cake cookie tiramisu.", rating: 2.5}
# ])

# p1 = Passenger.first
# p2 = Passenger.second
# p3 = Passenger.third
# p4 = Passenger.fourth
# p5 = Passenger.fifth



# Ride.create([
#     {driver_id: d1.id, passenger_id: Passenger.first.id, cost: 100.0, distance: 1.0 }, # use ids / the column name
#     {driver: d3 , passenger: p2, cost: 47.5, distance: 27.0 }, # use column name sans _id, just point to whole instance
#     {driver: d2 , passenger: p5, cost: 25.0, distance: 3.5 },
#     {driver: d3 , passenger: p5, cost: 789.2, distance: 1.89 },
#     {driver: d3 , passenger: p4, cost: 11.11, distance: 47.47 }
# ])