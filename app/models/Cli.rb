require "tty-prompt"
require "pry"
require 'rest-client'  
require 'json' 


class CLI
    @@prompt = TTY::Prompt.new
    @@artii1 = Artii::Base.new :font => 'doom'
    @@artii2 = Artii::Base.new :font => 'cybersmall'
    @@user = nil

    def splash
        puts Rainbow(@@artii2.asciify("Welcome to")).coral
        puts Rainbow(@@artii1.asciify("Bingewatcher")).gold
    end

    def startup
        sleep(1)
        puts Rainbow(@@artii2.asciify("Welcome to")).coral
        sleep(1.8)
        puts Rainbow(@@artii1.asciify("Bingewatcher")).gold
    end

    def welcome
        system('clear')
        self.startup
        sleep(1.5)
        self.main_menu
    end

## LOGIN IN SCREENS

    def main_menu
        system('clear')
        self.splash
        puts "\n\n"
        splash = @@prompt.select(Rainbow("Please Log In or Sign Up!").lightseagreen) do |prompt| 
            prompt.choice "Log In"
            prompt.choice "Sign Up"
            prompt.choice "Exit Bingewatcher"
        end
        case splash 
        when "Log In"
            sleep(0.5)
            self.login 
        when "Sign Up"
            sleep(0.5)
            self.signup 
        when "Exit Bingewatcher"
            sleep(1.5)            
            system('clear')
            self.splash
            puts "\n\n"
            sleep(2)
            puts "Thanks for using #{Rainbow("Bingewatcher").gold}! Please come again." 
            puts "\n\n\n\n\n"
            sleep(2)
            exit
        end
    end

    def login
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("LOGIN").lightseagreen
        puts "\n"
        username = @@prompt.ask("What is your Name?")
        puts "\n"
        password = @@prompt.mask("What is your Password?")
        @@user = User.find_by(name: username, password: password)
        if @@user
            sleep(0.5)
            self.login_main_menu
        else
            sleep(0.5)
            puts "\n"
            puts "I'm sorry, but that did not match our records."
            sleep(1.5)
            puts "\n"
            puts "...loading previous page..."
            sleep(2)            
            self.main_menu
        end
    end

    def signup
        system('clear')
        self.splash
        puts "\n\n"
        username = @@prompt.ask("What would you like to be called?")
        puts "\n"
        password = @@prompt.ask("What would you like your password to be?")
        @@user = User.create(name: username, password: password)
        puts "\n\n"
        sleep(1.2)
        puts "Thank you for joining us"
        sleep(1.5)
        puts "\n"
        puts "Taking you to the login now"
        sleep(1.8)
        self.main_menu
    end

    def logout
        sleep(1)
        system('clear')
        self.splash
        puts "\n\n"
        sleep(1)
        puts "Logging out"
        sleep(1.2)
        puts "\n"
        puts "It's been reel..."
        sleep(2)
        system('clear')
        sleep(0.5)
        self.welcome
    end


### AFTER SUCCESSFUL LOGIN

    def login_main_menu
        sleep(0.6)
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("Hi, #{Rainbow(@@user.name.capitalize).coral}").lightseagreen
        puts Rainbow("What would you like to do?").lightseagreen
        puts "\n"
        menu = @@prompt.select("Main Menu") do |prompt|
            # prompt.choice "average"
            prompt.choice "Create a New Movie"
            prompt.choice "See a list of Movies"
            prompt.choice "View your Reviews"
            prompt.choice "Update an Existing Review"
            prompt.choice "Create a New Review"
            prompt.choice Rainbow("Delete a Review").red
            prompt.choice "Logout"
            prompt.choice Rainbow("Delete User").red
            prompt.choice "Exit Bingewatcher"
        end
        case menu
        # when "average"
        #     self.average
        when "Create a New Movie"
            self.create_movie
        when "See a list of Movies"
            self.list_movies_menu
        when "View your Reviews"
            self.user_reviews_results
        when "Update an Existing Review"
            self.change_review_menu
        when "Create a New Review"
            self.create_review
        when Rainbow("Delete a Review").red
            self.review_delete_menu
        when "Logout"
            self.logout
        when Rainbow("Delete User").red
            self.delete_user_menu
        when "Exit Bingewatcher"
            sleep(1.5)            
            system('clear')
            self.splash
            puts "\n\n"
            sleep(2)
            puts "Thanks for using #{Rainbow("Bingewatcher").gold}! Please come again." 
            puts "\n\n\n\n\n"
            sleep(2)
            exit
        end
    end

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
        when "View your Reviews"
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

    def user_reviews_results 
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("YOUR REVIEWS").lightseagreen
        puts "\n"
        self.user_reviews.each do |review|
            puts "You have watched #{Rainbow(review.movie.title).orange}, and given it #{Rainbow(review.rating).salmon} stars."
        end
        puts "\n\n"
        self.footer_menu
    end

    def user_reviews 
        results =  Review.all.select {|review| review.user_id == @@user.id}
        results
    end



    def change_review_menu
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("UPDATE REVIEW").lightseagreen
        puts "\n"
        self.user_reviews.each do |review|
            puts "You have watched #{Rainbow(review.movie.title).orange}, and given it #{Rainbow(review.rating).salmon} stars."
        end
        puts "\n\n\n"
        review_titles = user_reviews.map {|review| review.movie.title}
        selection = @@prompt.select("Select a Review to Update", review_titles)
        change_review(selection)
    end

    def change_review(selection)  ### Helper for change_review_menu
        found_review = Review.all.select {|review| (review.movie.title == selection) && (review.user.name == @@user.name)}.first
        new_rating = @@prompt.ask("What is the new rating you would like to give #{Rainbow(found_review.movie.title).orange}?")
        # found_review.update(rating: new_rating)
        # found_review.rating = new_rating
        # found_review.save
        found_review.update(rating: new_rating)

        sleep(0.6)
        puts "your new rating for #{Rainbow(found_review.movie.title).orange} is #{Rainbow(found_review.rating).salmon}."

        puts "\n\n"
        self.footer_menu
    end


    
    def create_review  
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("CREATE NEW REVIEW").lightseagreen
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
            puts "New review has been recorded!  You have given #{Rainbow(new_review.movie.title).orange} a rating of #{Rainbow(new_review.rating).salmon}."
            puts "\n\n"
        elsif (does_movie_exist == true) && (does_review_exist == true)
            old_review = Review.all.select {|review| (review.movie.title == mov_title) && (review.user.name == @@user.name)}.first
            puts "\n"
            puts "You have previously given #{Rainbow(mov_title).orange} a rating of #{Rainbow(old_review.rating).salmon}."
            puts "\n\n"
        else
            puts "Sorry #{Rainbow(@@user.name).coral}, but #{Rainbow(mov_title).orange} doesn't exist in our system yet."
            puts "\n\n"
        end
        self.footer_menu
    end

    # def average
    #     movie_title = @@prompt.ask("gimmie a movie title")
    #     puts "#{self.global_average_reviews(movie_title)}"
    # end


    # def global_average_reviews(movie_title)
    #     all_reviews = Review.all.select {|review| review.movie.title == movie_title}
    #     average = (all_reviews.size/all_reviews.count).round(2)
    #     binding.pry
    # end

    





    ###Movie Methods###

    def create_movie  ###adjust sleep timers   
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("CREATE NEW MOVIE").lightseagreen
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
        self.splash
        puts "\n\n"
        puts Rainbow("ALL MOVIES IN THE SYSTEM").lightseagreen
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
        self.splash
        puts "\n\n"
        puts Rainbow("DELETE USER").red
        puts "\n"
        menu = @@prompt.select("Are you sure you want to delete your user? (this cannot be reversed)") do |prompt|
            prompt.choice Rainbow("Yes").red
            prompt.choice "No"
        end
        case menu
        when Rainbow("Yes").red
            User.delete(@@user.id)
            sleep(0.5)
            system('clear')
            self.splash
            puts "\n\n"
            puts "Your account: #{Rainbow(@@user.name).coral} was #{Rainbow("DELETED").red}. Returning to login menu."
            sleep(3)
            self.main_menu
        when "No"  
            sleep(1)
            self.footer_menu
        end      
    end


    def review_delete_menu
        system('clear')
        self.splash
        puts "\n\n"
        puts Rainbow("DELETE REVIEW").red
        puts "\n"
        review_titles = user_reviews.map {|review| review.movie.title}
        selection = @@prompt.select("Select Review for Deletion (this cannot be reversed)", review_titles)
        # binding.pry
        delete_review(selection)
        sleep(0.8)
        puts "\n\n"
        puts "#{Rainbow(selection).orange} has been removed from your history."
        puts "\n\n"
        self.footer_menu
    end

    def delete_review(title) ## Helper for review_delete_menu
        found_review = Review.all.select {|review| (review.movie.title == title) && (review.user.name == @@user.name) }
        Review.find_by(id: found_review.first.id).destroy
    end
end