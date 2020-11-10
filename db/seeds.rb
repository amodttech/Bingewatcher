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

m1 = Movie.create(:title=>'Deep Red', :director=>'Dario Argento', :year=>1975, :genre=>'Horror', :country=>'Italy', :synopsis=>'A pianist investigates a series of murders performed by a mysterious figure wearing black leather gloves.')
m2 = Movie.create(:title=>'Phantom of the Paradise', :director=>'Brian de Palma', :year=>1974, :genre=>'Horror', :country=>'USA', :synopsis=>'A pianists lifes work is stolen by a record tycoon, and he murders everyone who plays it.')
m3 = Movie.create(:title=>'Saving Private Ryan', :director=> 'Steven Spielberg', :year=>1998, :genre=>'Action', :country =>'USA', :synopsis=>'saving ryan from the war')
m4 = Movie.create(:title=>'Titanic', :director=>'James Cameron', :year=>1997, :genre=>'Drama', :country=>'USA', :synopsis=>'boat goes down...')

# u1 = User.create(:name=>'Aaron')
# u2 = User.create(:name=>'Julio')

# # r1 = Review.create(u1, m1, 4)
# # r2 = Review.create(u1, m2, 2)
# # r3 = Review.create(u1, m3, 9)
# # r4 = Review.create(u2, m1, 2)
# # r5 = Review.create(u2, m3, 6)
# # r6 = Review.create(u2, m4, 10)


