class Movielist < ActiveRecord::Base
    has_many :movies, through: :addmovietomovielists
    has_many :addmovietomovielists
    belongs_to :user
end

