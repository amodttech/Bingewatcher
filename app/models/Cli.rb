require "tty-prompt"
require "pry"
require 'rest-client'  
require 'json' 


class CLI
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'slant'
    @@user = nil

    def welcome
        system('clear')
        puts @@artii.asciify("Welcome to")
        puts @@artii.asciify("Bingewatcher")
        self.main_menu
        # login_main_menu
    end

## LOGIN IN SCREENS

    def main_menu
        sleep(1)
        system('clear')
        splash = @@prompt.select("Please Log In or Sign Up!") do |prompt| 
            prompt.choice "Log In"
            prompt.choice "Sign Up"
        end
        case splash 
        when "Log In"
            self.login 
        when "Sign Up"
            self.signup 
        end

    end

    def login
        username = @@prompt.ask("What is your Name?")
        password = @@prompt.mask("What is your Password?")
        @@user = User.find_by(name: username, password: password)
        if @@user
            # system('clear')
            self.login_main_menu
        else
            puts "Incorrect"
            sleep(1)
            puts "taking you back"
            sleep(1)
            self.main_menu
        end
    end

    def signup
        username = @@prompt.ask("What would you like to be called?")
        password = @@prompt.ask("What would you like your password to be?")
        @@user = User.create(name: username, password: password)
        puts "Thank you for joining us"
        sleep(0.5)
        puts "Taking you to the login now"
        sleep(0.8)
        system('clear')
        self.main_menu
    end


### AFTER SUCCESSFUL LOGIN

    def login_main_menu
        puts "Hi #{@@user.name} what would you like to do?"
        menu = @@prompt.select("Main Menu") do |prompt|
            prompt.choice "Reviews"
            prompt.choice "Movies"
            prompt.choice "Logout"
            prompt.choice Rainbow("Delete User").red
            prompt.choice "Exit Bingewatcher"
        end
        case menu
        when "Reviews"
            self.reviews_menu
        when "Movies"
            self.movies_menu
        when "Logout"
            sleep(0.5)
            system('clear')
            sleep(1)
            puts "goodbye"
            sleep(2)
            self.welcome    
        when Rainbow("Delete User").red
            self.delete_user_menu
        when "Exit Bingewatcher"
            system('clear')
            puts "Thanks for using Bingewatcher! please come again."    
        end
    end

    def reviews_menu
      system('clear')
      puts "Reviews Menu"
      menu = @@prompt.select("What would you like to do?") do |prompt|
        prompt.choice "Review a new Movie"
        prompt.choice "View your Reviews"
        prompt.choice "Update an existing Review"
        prompt.choice "View all average Reviews"
        prompt.choice Rainbow("Delete a Review").red
        prompt.choice "Return to Main Menu"
      end
      case menu
      when "Review a new Movie"
        self.create_review
      when "View your Reviews"
        self.user_reviews_results
      when "Update an existing Review"
        self.change_review
      when "View all average Reviews"
        self.global_average_reviews
      when Rainbow("Delete a Review").red 
        self.review_delete_menu
      when "Return to Main Menu"
        sleep(0.5)
        self.login_main_menu
      end
    end

    def movies_menu
        system('clear')
        puts "Movies Menu"
        puts "\n\n"
        menu = @@prompt.select("What would you like to do?") do |prompt|
            prompt.choice "Add a new Movie"
            prompt.choice "See a list of Movies"
            prompt.choice Rainbow("Delete a Movie").red
            prompt.choice "Return to Main Menu"
        end
        case menu
        when "Add a new Movie"
              self.create_movie
        when "See a list of Movies"
            Movie.all.each {|movie| puts movie.title}
        when Rainbow("Delete a Movie").red

        when "Return to Main Menu"  
            self.login_main_menu  
        end

    end


        ##Review Methods##

    def user_reviews 
        results =  Review.all.select {|review| review.user_id == @@user.id}
        results
    end


    def user_reviews_results ## currently outputs nicely
        self.user_reviews.each do |review|
            puts "You have watched #{review.movie.title}, and given it #{review.rating} stars."
        end
        puts "\n\n\n"
        if @@prompt.yes?("Back to previous menu?")
            self.reviews_menu
        else
            self.user_reviews_results
        end
    end



    def create_review  ## Is currently returning an instance, could be more legible
        system('clear')
        puts "New Review"
        mov_title = @@prompt.ask("What is the Movie title?", required: true)
        mov_rating = @@prompt.ask("How many stars out of five would you rate this movie?")
        mov = Movie.find_by(title: mov_title)
        new_review = Review.create(user: @@user, movie: mov, rating: mov_rating)
        puts new_review
        sleep(1)
        puts "Thank you for your insights, your review has been documented.  Returning you to the menu."
        sleep(3)
        self.reviews_menu
    end



    def global_average_reviews
        # Movie.all.map {|mov| mov.review.rating}
        puts Review.group(:movie).count
        binding.pry
    end

    
    ###Movie Methods###

    def create_movie  ###adjust sleep timers
        system('clear')
        puts "New Movie"
        mov_title = @@prompt.ask("What is the Movie title?", require: true)
        if Movie.all.any? {|movie| movie.title == mov_title}
            puts "Hey, it looks like #{mov_title} already has an entry."
            var1 = @@prompt.yes?("Would you like to leave a review?")
            if var1 
                self.create_review
            else
                puts "okay fine, sending you back to the movie menu"
                sleep(0.7)
                self.movies_menu
            end
        else
            new_movie = Movie.create(title: mov_title)
            puts "Movie: '#{new_movie.title}' has been created!"
            var2 = @@prompt.yes?("Would you like to leave a review?")
            if var2 
                self.create_review
            else
                puts "okay fine, sending you back to the movie menu"
                sleep(0.7)
                self.movies_menu
            end
        end
    end


    
    
  ## DELETE MENUS ##

    def delete_user_menu
        system('clear')
        puts "Delete User Menu"
        menu = @@prompt.select("Are you sure you want to delete your user?") do |prompt|
            prompt.choice Rainbow("Yes").red
            prompt.choice "No"
        end
        case menu
        when Rainbow("Yes").red
            User.delete(@@user.id)
            system("clear")
            puts "Your account was deleted. Returning to login menu."
            self.main_menu
        when "No"  
            self.login_main_menu
        end      
    end

    # def user_reviews 
    #     #binding.pry
    #     results =  Review.all.select {|review| review.user_id == @@user.id}
    #     results
    # end

    def review_delete_menu
        review_titles = user_reviews.map {|review| review.movie.title}
        selection = @@prompt.select("Reviews to Delete", review_titles)
        # binding.pry
        delete_review(selection)

    end

    def delete_review(title)
        found_review = Review.all.select {|review| review.movie.title == title}
        Review.delete(found_review.first.id)
    end


end