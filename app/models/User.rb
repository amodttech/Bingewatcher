require "tty-prompt"


class User < ActiveRecord::Base
    has_many :reviews
    has_many :movielists
    has_many :movies, through: :reviews
    # has_many :movies, through: :movieslists
end