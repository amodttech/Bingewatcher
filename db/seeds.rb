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

Movie.create(title: 'Deep Red', director: 'Dario Argento', year: 1975, genre: 'Horror', country: 'Italy', synopsis: 'A pianist investigates a series of murders performed by a mysterious figure wearing black leather gloves.')
Movie.create(title: 'Phantom of the Paradise', director: 'Brian de Palma', year: 1974, genre: 'Horror', country: 'USA', synopsis: 'A pianists lifes work is stolen by a record tycoon, and he murders everyone who plays it.')
Movie.create(title: 'Saving Private Ryan', director:  'Steven Spielberg', year: 1998, genre: 'Action', country:  'USA', synopsis: 'saving ryan from the war')
Movie.create(title: 'Titanic', director: 'James Cameron', year: 1997, genre: 'Drama', country: 'USA', synopsis: 'boat goes down...')


User.create(name: 'Aaron')
User.create(name: 'Julio')

# Review.create(user_id: u1, movie_id: m1, rating: 3)
