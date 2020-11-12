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


Movie.create([
    {title: 'Deep Red', director: 'Dario Argento', year: 1975, genre: 'Horror', country: 'Italy', synopsis: 'A pianist investigates a series of murders performed by a mysterious figure wearing black leather gloves.'},
    {title: 'Phantom of the Paradise', director: 'Brian de Palma', year: 1974, genre: 'Horror', country: 'USA', synopsis: 'A pianists lifes work is stolen by a record tycoon, and he murders everyone who plays it.'},
    {title: 'Saving Private Ryan', director:  'Steven Spielberg', year: 1998, genre: 'Action', country:  'USA', synopsis: 'saving ryan from the war'},
    {title: 'Titanic', director: 'James Cameron', year: 1997, genre: 'Drama', country: 'USA', synopsis: 'boat goes down...'},
    {title: 'Running Man', director: 'Paul Michael Glaser', year: 1987, genre: 'Action', country: 'USA', synopsis: 'future gladiator'}

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

Movielist.create([
    {user: u1},
    {user: u2},
    {user: u3},
    {user: u4},
    {user: u5}
])

ml1 = Movielist.first
ml2 = Movielist.second
ml3 = Movielist.third
ml4 = Movielist.fourth
ml5 = Movielist.fifth

# Addmovietomovielist.create([
#     {movie: Movie.all.sample, movielist: Movielist.all.sample, priority: 1},
#     {movie: m2, movielist: ml5, priority: 2},
#     {movie: m3, movielist: ml1, priority: 3}
# ])

  