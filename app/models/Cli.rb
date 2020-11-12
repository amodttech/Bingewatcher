require "tty-prompt"
require "pry"
require 'rest-client'  
require 'json' 


class CLI
    @@prompt = TTY::Prompt.new
    @@artii = Artii::Base.new :font => 'epic'
    @@user = nil

    def splash
        puts @@artii.asciify("Welcome to")
        puts @@artii.asciify("Bingewatcher")
    end

    def welcome
        system('clear')
        self.splash
        sleep(1.5)
        self.main_menu
        # login_main_menu
    end

## LOGIN IN SCREENS

    def main_menu
        system('clear')
        self.splash
        puts "\n\n"
        splash = @@prompt.select("Please Log In or Sign Up!") do |prompt| 
            prompt.choice "Log In"
            prompt.choice "Sign Up"
        end
        case splash 
        when "Log In"
            sleep(0.5)
            self.login 
        when "Sign Up"
            sleep(0.5)
            self.signup 
        end
    end

    def login
        system('clear')
        self.splash
        puts "\n\n"
        puts "Login"
        puts "\n"
        username = @@prompt.ask("What is your Name?")
        password = @@prompt.mask("What is your Password?")
        @@user = User.find_by(name: username, password: password)
        if @@user
            self.login_main_menu
            system('clear')
        else
            puts "Incorrect"
            sleep(1)
            puts "taking you back"
            sleep(1)
            self.main_menu
        end
    end

    def signup
        system('clear')
        self.splash
        puts "\n\n"
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
        sleep(0.6)
        system('clear')
        self.splash
        puts "\n\n"
        puts "Hi #{Rainbow(@@user.name.capitalize).blue} what would you like to do?"
        puts "\n"
        menu = @@prompt.select("Main Menu") do |prompt|
            prompt.choice "Create a New Movie"
            prompt.choice "See a list of Movies"
            prompt.choice "See a list of your Reviews"
            prompt.choice "Update an Existing Review"
            prompt.choice "Create a New Review"
            prompt.choice Rainbow("Delete a Review").red
            prompt.choice "Logout"
            prompt.choice Rainbow("Delete User").red
            prompt.choice "Exit Bingewatcher"
        end
        case menu
        when "Create a New Movie"
            self.create_movie
        when "See a list of Movies"
            self.list_movies_menu
        when "See a list of your Reviews"
            self.user_reviews_results
        when "Update an Existing Review"
            self.change_review_menu
        when "Create a New Review"
            self.create_review
        when Rainbow("Delete a Review").red
            self.review_delete_menu
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
            puts "Thanks for using #{Rainbow("Bingewatcher").green}! Please come again." 
            puts "\n\n\n\n\n"
            exit
        end
    end

    # def reviews_menu
    #   system('clear')
    #   puts "Reviews Menu"
    #   puts "\n\n"
    #   menu = @@prompt.select("What would you like to do?") do |prompt|
    #     prompt.choice "Review a new Movie"
    #     prompt.choice "View your Reviews"
    #     prompt.choice "Update an existing Review"
    #     prompt.choice "View all average Reviews"
    #     prompt.choice Rainbow("Delete a Review").red
    #     prompt.choice "Return to Main Menu"
    #   end
    #   case menu
    #   when "Review a new Movie"
    #     self.create_review
    #   when "View your Reviews"
    #     self.user_reviews_results
    #   when "Update an existing Review"
    #     self.change_review_menu
    #   when "View all average Reviews"
    #     self.global_average_reviews
    #   when Rainbow("Delete a Review").red 
    #     self.review_delete_menu
    #   when "Return to Main Menu"
    #     sleep(0.5)
    #     self.login_main_menu
    #   end
    # end

    # def movies_menu
    #     system('clear')
    #     puts "Movies Menu"
    #     puts "\n\n"
    #     menu = @@prompt.select("What would you like to do?") do |prompt|
    #         prompt.choice "Add a new Movie"
    #         prompt.choice "See a list of Movies"
    #         prompt.choice "Return to Main Menu"
    #     end
    #     case menu
    #     when "Add a new Movie"
    #           self.create_movie
    #     when "See a list of Movies"
    #         self.list_movies_menu
    #     when "Return to Main Menu"  
    #         self.login_main_menu  
    #     end

    # end

    def footer_menu
        menu = @@prompt.select("What would you like to do next?") do |prompt| 
            prompt.choice "Create a New Movie"
            prompt.choice "See a list of Movies"
            prompt.choice "View your Reviews"
            prompt.choice "Update an Existing Review"
            prompt.choice "Create a New Review"
            prompt.choice Rainbow("Delete a Review").red
            prompt.choice "Back to Main Menu"
        end
        case menu
        when "Create a New Movie"
            self.create_movie
        when "See a list of Movies"
            self.list_movies_menu
        when "See a list of your Reviews"
            self.user_reviews_results
        when "Update an Existing Review"
            self.change_review_menu
        when "Create a New Review"
            self.create_review
        when Rainbow("Delete a Review").red
            self.review_delete_menu
        when "Back to Main Menu"
            self.login_main_menu
        end
    end

        ##Review Methods##

    def user_reviews 
        results =  Review.all.select {|review| review.user_id == @@user.id}
        results
    end


    def user_reviews_results 
        system('clear')
        puts "Your Reviews"
        puts "\n"
        self.user_reviews.each do |review|
            puts "You have watched #{Rainbow(review.movie.title).orange}, and given it #{Rainbow(review.rating).pink} stars."
        end
        puts "\n\n"
        self.footer_menu
    end


    def change_review_menu
        system('clear')
        puts "Update Review"
        puts "\n"
        self.user_reviews.each do |review|
            puts "You have watched #{Rainbow(review.movie.title).green}, and given it #{Rainbow(review.rating).orange} stars."
        end
        puts "\n\n\n"
        review_titles = user_reviews.map {|review| review.movie.title}
        selection = @@prompt.select("Select a Review to Update", review_titles)
        change_review(selection)
    end

    def change_review(selection)  ### Helper for change_review_menu
        found_review = Review.all.select {|review| review.movie.title == selection}.first
        new_rating = @@prompt.ask("What is the new rating you would like to give #{Rainbow(found_review.movie.title).orange}?")
        # found_review.update(rating: new_rating)
        found_review.rating = new_rating
        found_review.save


        sleep(0.6)
        puts "your new rating for #{Rainbow(found_review.movie.title).orange} is #{Rainbow(found_review.rating).pink}."

        puts "\n\n"
        self.footer_menu
    end


    
    def create_review  
        system('clear')
        puts "Create New Review"
        puts "\n"
        mov_title = @@prompt.ask("What is the Movie title?", required: true)
            does_movie_exist = Movie.all.any? {|movie| movie.title == mov_title}
            does_review_exist = Review.all.any? {|review| (review.movie.title == mov_title) && (review.user.name == @@user.name)}
        if (does_movie_exist == true) && (does_review_exist == false)
            puts "\n\n"
            mov_rating = @@prompt.ask("How many stars out of five would you rate this movie?", convert: :int)
            mov = Movie.find_by(title: mov_title)
            new_review = Review.create(user: @@user, movie: mov, rating: mov_rating)
            puts "\n\n"
            puts "New review has been recorded!  You have given #{Rainbow(new_review.movie.title).orange} a rating of #{Rainbow(new_review.rating).pink}."
            puts "\n\n"
        elsif (does_movie_exist == true) && (does_review_exist == true)
            old_review = Review.all.select {|review| (review.movie.title == mov_title) && (review.user.name == @@user.name)}.first
            puts "\n"
            puts "You have previously given #{Rainbow(mov_title).orange} a rating of #{Rainbow(old_review.rating).pink}."
            puts "\n\n"
        else
            puts "Sorry #{Rainbow(@@user.name).blue}, but #{Rainbow(mov_title).orange} doesn't exist in our system yet."
            puts "\n\n"
        end
        self.footer_menu
    end



    # def global_average_reviews
    #     # Movie.all.map {|mov| mov.review.rating}
    #     puts Review.group(:movie).count
    #     binding.pry
    # end

    
    ###Movie Methods###

    def create_movie  ###adjust sleep timers   
        system('clear')
        puts "New Movie"
        puts "\n"
        mov_title = @@prompt.ask("What is the Movie title?", require: true)
        if Movie.all.any? {|movie| movie.title == mov_title}
            puts "Hey, it looks like #{Rainbow(mov_title).orange} already has an entry."
            var1 = @@prompt.yes?("Would you like to leave a review?")
            if var1 
                self.create_review
            end
        else
            new_movie = Movie.create(title: mov_title)
            puts "Movie: '#{Rainbow(new_movie.title).orange}' has been created!"
        end
        
        puts "\n\n"

        self.footer_menu
    end

    def list_movies_menu
        system('clear')
        puts "List of all Movies in System"
        puts "\n"
        self.list_movies
        puts "\n\n"
        self.footer_menu
    end

    def list_movies
        title_array = Movie.all.map {|movie| movie.title}
        title_array.sort!  #puts all titles in alphabetical order
        title_array.each {|title| puts "#{Rainbow(title).orange}"}
    end

    
    
  ## DELETE MENUS ##

    def delete_user_menu
        system('clear')
        puts "Delete User Menu"
        puts "\n"
        menu = @@prompt.select("Are you sure you want to delete your user?") do |prompt|
            prompt.choice Rainbow("Yes").red
            prompt.choice "No"
        end
        case menu
        when Rainbow("Yes").red
            User.delete(@@user.id)
            system("clear")
            puts "Your account was deleted. Returning to login menu."
            sleep(2)
            self.main_menu
        when "No"  
            sleep(1)
            self.footer_menu
        end      
    end


    def review_delete_menu
        system('clear')
        puts "Delete Review Menu"
        puts "\n"
        review_titles = user_reviews.map {|review| review.movie.title}
        selection = @@prompt.select("Reviews to Delete", review_titles)
        # binding.pry
        delete_review(selection)
        sleep(0.8)
        puts "\n\n"
        puts "#{Rainbow(selection).orange} has been removed from your history."
        puts "\n\n"
        self.footer_menu
    end

    def delete_review(title) ## Helper for review_delete_menu
        found_review = Review.all.select {|review| review.movie.title == title}
        Review.delete(found_review.first.id)
    end


end