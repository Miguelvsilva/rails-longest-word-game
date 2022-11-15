require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("a".."z").to_a.sample }

  end

  def score
    @letters = params[:letters]
    if check_if_contains
      @final = "Sorry but #{params[:question]} can't be built out of #{@letters}"
    elsif parsing == false
      @final = "Sorry but #{params[:question]} does not seem to be a valid English word..."
    else
      @final = "Congratulations! #{params[:question]} is a valid English word!"
    end
  end

  private

  def check_if_contains
    array = params[:question].split("")
    @letters = @letters.split(" ")

    array.difference(@letters).any?
  end

  def parsing
    url = "https://wagon-dictionary.herokuapp.com/#{params[:question]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    return user["found"]
  end
end
