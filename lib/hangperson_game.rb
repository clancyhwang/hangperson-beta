class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word, :guesses, :wrong_guesses, :repeated

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    @repeated = false
    if letter.nil? or letter == '' or not letter =~ /^[a-z]$/i
      raise ArgumentError
    end

    if @guesses.include?(letter) or @wrong_guesses.include?(letter)
      @repeated = true
    end

    if @word.include?(letter) and not @guesses.include?(letter)
      @guesses += letter

    elsif not @word.include?(letter) and not @wrong_guesses.include?(letter)
      @wrong_guesses += letter

    else
      false
    end
  end

  def word_with_guesses
    display_word = ""
    @word.gsub(/./) do |letter|
      if @guesses.include?(letter)
        display_word += letter
      else
        display_word += '-'
      end
    end
    display_word
  end

  def check_win_or_lose
    if @word == word_with_guesses
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # Get a word from remote "random word" service
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
