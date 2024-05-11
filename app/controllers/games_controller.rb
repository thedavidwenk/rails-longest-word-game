require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    session[:letters] = @letters
  end

  def score
    @answer = params[:answer]
    @letters = session[:letters] || []
    
    begin
      url = "https://dictionary.lewagon.com/#{@answer}"
      word_serialized = URI.open(url).read
      word = JSON.parse(word_serialized)
    end



    def same_letters?(letters, answer)  
      answer.chars.all? { |char| letters.include?(char) } 
    end

    if  word["found"] && same_letters?(@letters, @answer.upcase)
      @response = "The word is valid according to the grid and is an English word ✅"
    elsif !word["found"] && same_letters?(@letters, @answer.upcase)
      @response = "The word is valid according to the grid, but is not a valid English word ❌"
    else !same_letters?(@letters, @answer)
      @response = "The word can’t be built out of the original grid ❌"
    end


    # show the score on /score page
    # pass params (done)
    # display the letters array (done)
    # parse the API (done)
    #
    # word
    # => {"found"=>true, "word"=>"test", "length"=>4}

    # to check if word is english
    # define if / else logic 
    # display a play again button (done)

   #  raise
  end
end
