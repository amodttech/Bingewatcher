class Addmovietomovielist < ActiveRecord::Base
    belongs_to :movie
    belongs_to :movielist
end

