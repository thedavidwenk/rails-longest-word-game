require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    session[:letters] = @letters
    session[:points] ||= 0 
  end

  def score
    @answer = params[:answer]
    @letters = session[:letters] || []

    begin
      word = JSON.parse(URI.open("https://dictionary.lewagon.com/#{@answer}").read)
    rescue => error
      # Handle API errors here (more on this later)
      return "Error checking word: #{error.message}"
    end

    def same_letters?(letters, answer)  
      answer.chars.all? { |char| letters.include?(char) } 
    end

    if  word["found"] && same_letters?(@letters, @answer.upcase)
      @points = word["length"] 
      session[:points] += @points
      @response = "The word is valid according to the grid and is an English word. You earned #{@points} points! 🎉 "
    elsif !word["found"] && same_letters?(@letters, @answer.upcase)
      @response = "The word is valid according to the grid, but is not a valid English word ❌"
    else !same_letters?(@letters, @answer)
      @response = "The word can’t be built out of the original grid ❌"
    end

  end
end
