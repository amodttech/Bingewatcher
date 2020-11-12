class Viewer
    attr_accessor :username
    @@all = []
  
    def initialize(username)
      @username = username
      self.class.all << self
    end
  
    def self.all
      @@all
    end
    
    def reviews
      # Review.all.select {|reviews| reviews.viewer == self}  
      #My code, the enum variable should not be plural because it's referring to a singular iteration
      Review.all.select {|review| review.viewer == self} #solution code
    end
  
    def reviewed_movies
      self.reviews.map {|reviews| reviews.movie}
    end
  
    def reviewed_movie?(movie)
      # Review.all.select {|review| review.viewer == self && review.movie == movie}
      # var = Review.all.select {|review| (review.viewer == self) && (review.movie == movie)}[0]
      # if var != nil
      #   true
      # else
      #   false
      # end
    #wow, this one is convoluted.  can't wait to figure out how to do this more elegantly.
      self.reviewed_movies.include?(movie)  #solution code
    end
  
    # def rate_movie(movie, rating)
    #   if self.reviewed_movie?(movie) == false
    #     Review.new(self, movie, rating)
    #   else
    #     ##uuuuuggggggh halp
    #   end
  
    def rate_movie(movie, rating) #solution
      # if they reviewed the movie
      #   find the review, update the rating
      if self.reviewed_movie?(movie)
        target_review = self.reviews.find {|review| review.movie == movie} #finds the review for the passed movie
        target_review.rating = rating #sets the rating on the found movie, also, neccessitates attr_accessor for rating
      else
      Review.new(self, movie, rating)
      end
    end
  end
  
  
  class Review
    attr_accessor :rating
    attr_reader :viewer, :movie
    @@all = []
  
    def initialize(viewer, movie, rating)
        @viewer = viewer
        @movie = movie
        @rating = rating.to_i
        @@all << self
    end
  
    def self.all
        @@all
    end
  
  end
  
  class Movie
    attr_accessor :title
    @@all = []
  
    def initialize(title)
      @title = title
      self.class.all << self
    end
  
    def self.all
      @@all
    end
  
    def reviews
      # Review.all.select {|reviews| reviews.movie == self} 
      #enum var should be singular
      Review.all.select {|review| review .movie == self} #solution code
      Review.all.find_all {|review| review.movie == self} #alternative solution
    end
  
    def reviewers
      self.reviews.map {|reviews| reviews.viewer}
    end
  
    def rating #more semantic name for this helper method would be 'ratings'
      self.reviews.map {|review| review.rating}
    end
  
    def average_rating #this method works, but errors on a movie without any reviews.  also, use a float instead of INTs
      # self.rating.sum/self.rating.size     #my code
      self.reviews.sum {|review| review.rating} / self.reviews.size
    end
  
    def self.highest_rated 
      #deliverable was looking for an instance of Movie with highest average rating.
      #think about using self.all.max_by and Movie#average_rating
      # Review.all.max_by {|review| review.rating} #  my code
      #might want to google get max value from array
      self.all.max_by {|m| m.average_rating}
    end
  end
  
  