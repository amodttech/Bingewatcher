require "tty-prompt"


class User < ActiveRecord::Base
    has_many :reviews
    has_many :movielists
    has_many :movies, through: :reviews
    # has_many :movies, through: :movieslists

    # CRUD

    # Create

    # User.new
    # User.save
    # User.create

    # Read

    # User.all
    # User.find(id)
    # User.find_by({})
    # User.where()

    # Update

    # User#save

end