require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @check = JSON.parse(URI.open(url).read)
    @is_included = included?(params[:word], params[:letters])

    if @check['found'] == true && @is_included == true
      @result = "Congratulations! #{params[:word].upcase} is a valid English word!"
    elsif @check['found'] == true && @is_included == false
      @result = "Sorry but #{params[:word].upcase} cannot be built from letters."
    else
      @result = "Sorry but #{params[:word].upcase} is not a real word"
    end
  end

  private

  def included?(word, letters)
    # iterate over every letter of word
    # if every letter of letter is included
    word_letters = word.chars unless word.nil?
    letter_letters = letters unless letters.nil?
    word_letters.all? { |letter| letter.include?(letter_letters) } #=> true
  end
end
