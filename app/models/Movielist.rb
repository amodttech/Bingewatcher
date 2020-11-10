class Movielist < ActiveRecord::Base
    has_many :movies, through: :Addmovietomovielists
    has_many :Addmovietomovielists
    belongs_to :user
end

