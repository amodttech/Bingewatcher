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
            system('clear')
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
            self.delete_menu
        end
    end

    def reviews_menu
      system('clear')
      puts "Reviews Menu"
      menu = @@prompt.select("What would you like to do?") do |prompt|
        prompt.choice "Review a new Movie"
        prompt.choice "View your Reviews"
        prompt.choice "Return to Main Menu"
      end
      case menu
      when "Review a new Movie"
        self.create_review
      when "View your Reviews"
        self.view_reviews
      when "Return to Main Menu"
        sleep(0.5)
        self.login_main_menu
      end
    end

    def movies_menu
        system('clear')
        puts "Movies Menu"
        menu = @@prompt.select("What would you like to do?") do |prompt|
            prompt.choice "Add a new Movie"
            prompt.choice "See a list of Movies"
            prompt.choice "Delete a Movie"
            prompt.choice "Return to Main Menu"
        end
        case menu
        when "Add a new Movie"
              self.create_movie
        when "See a list of Movies"
            Movie.all.each {|movie| puts movie.title}
        when "Delete a Movie"

        when "Return to Main Menu"  
            self.login_main_menu  
        end

    end


        ##Review Methods##

    def view_reviews ## currently outputs nicely
        results =  Review.all.select {|review| review.user_id == @@user.id}
        results.each do |review|
            puts "You have watched #{review.movie.title}, and given it #{review.rating} stars."
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


    
    
  ## DELETE MENU ##

    def delete_menu
        system('clear')
        puts "Delete User Menu"
        menu = @@prompt.select("Are you sure you want to delete your user?") do |prompt|
            prompt.choice "Yes"
            prompt.choice "No"
        end
        case menu
        when "Yes"
        
        when "No"  
            self.login_main_menu
        end      

    end

end
    # def auth_sequence
    #     sleep(0.2)
    #     @@prompt.ask('What is your name?', required: true)


    # end



    # def auth_sequence
    #     sleep(1.5)
    #     @@user = User.first
    #     #self.display_menu
    #     choices = { "Log In" => 1,
    #         "Sign Up" => 2
    #     }
    #     choice = @@prompt.select("Would you like to sign up or log in?", choices)
    #     if choice == 1
    #         @@user = User.login
    #         if @@user
    #             self.display_menu
    #         else
    #             self.auth_sequence
    #         end
    #     else
    #         @@user = User.signup
    #         if @@user
    #             self.display_menu
    #         else
    #             self.auth_sequence
    #         end
    #     end
    # end

    # def display_menu
    #     # Displays the options to the user!
    #     system('clear')
    #     choices = { "Play a random category" => 1,
    #             "Search for a category" => 2, 
    #             "See my game results" => 3,
    #             "See leaderboard" => 4,
    #             "Select from all categories" => 5
    #         }
    #     action = @@prompt.select("What would you like to do?", choices)
    #     case action
    #     when 1 
    #         random_cat = Category.all.sample # gets random category from those seeded
    #         api_data = self.get_category_data(random_cat) # uses helper method to get clues from API
    #         self.play_game(random_cat.id, api_data) # plays the game!
    #     when 2
    #         puts "You chose to search"
    #     when 3
    #         puts "You chose to see results"
    #     when 4
    #         puts "You chose to see your game results"
    #     when 5
    #         chosen_category = self.choose_category # uses helper method to display and get category choice
    #         api_data = self.get_category_data(chosen_category) # uses helper method to get clues from API
    #         self.play_game(chosen_category.id, api_data) # plays the game!
    #     end
    # end

    # def choose_category
    #     # displays all seeded categories to user 
    #     category_titles = Category.all.map { |cat| cat.title }
    #     chosen_title = @@prompt.enum_select("Choose your category", category_titles, per_page: 10)
    #     Category.find_by(title: chosen_title)
    # end

    # def get_category_data(category)
    #     # binding.pry
    #     resp = RestClient.get("http://jservice.io/api/category?id=#{category.api_id}")
    #     JSON.parse(resp)
    #     # AI: send a request to the API for clues from the correct category, passed in as an argument
    # end

    # def play_game(category_id, category_data)
    #     # currently only shows 2 quesions in order to get the get the total possible score and
    #     # display the questions and get actual scores 
    #     possible = category_data["clues"].slice(0,2).sum { |clue| clue["value"] }
    #     total = category_data["clues"].slice(0,2).map do |clue|
    #         self.give_clue_prompt(category_data["title"], clue)
    #     end.sum
    #     puts "You scored #{total}!"
    #     Game.create(user_id: @@user.id, category_id: category_id, score: total, total_possible: possible)
    # end

    # def give_clue_prompt(title, clue)
    #     attempts = 0
    #     while attempts < 3
    #         system('clear')
    #         puts @@artii.asciify(title)
    #         puts "Your clue... \n"
    #         puts "#{clue["question"]} \n"
    #         guess = @@prompt.ask("What is your answer?")
    #         if guess == clue["answer"]
    #             puts "You did it!! Correct answer! \n\n"
    #             sleep(1.5)
    #             return clue["value"]
    #         end
    #         puts "Wrong! Try Again!" if attempts < 2
    #         sleep(0.5)
    #         attempts += 1
    #     end
    #     puts "Alas, you ran out of tries. The correct answer was: #{clue["answer"]} \n\n"
    #     sleep(1.5)
    #     return 0
    # end
