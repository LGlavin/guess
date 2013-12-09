require 'sinatra'

set :secret, rand(100)
set :guesses, 7

get '/' do 
  settings.guesses -= 1
  guess = params["guess"].to_i
  message = check_guess(settings.secret, guess)

  if settings.secret == guess || settings.secret == 0
    reset_game
    message += "Play Again!? A new number was generated!"
  end

  erb :index, :locals => {:secret => settings.secret, :message => message, :color => @color}
end

  def check_guess(guess, number)
    if guess == number
      @color = "green"
      "Yay! you got the #{number}!"
     elsif guess > number + 7
       @color = "yellow"
      "that is too low! guess again!"
    else guess < number - 7
        @color = "red"
       "that is too high! guess again!"
    end      
  end


  def reset_game
    settings.guesses = 7
    settings.secret = rand(100)
  end