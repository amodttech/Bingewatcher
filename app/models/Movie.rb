class Movie < ActiveRecord::Base
    has_many :reviews
    has_many :movielists, through: :Addmovietomovielists
    has_many :Addmovietomovielists
    # belongs_to :movielists, through: :Addmovietomovielists
    # belongs_to :user, through: :reviews

end