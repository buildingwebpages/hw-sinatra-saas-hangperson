class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def check_valid(letter)
     letter =~ /[a-zA-Z]/
  end
  
  def guess(letter)
    raise ArgumentError.new("Only upper/lower case letters allowed") unless check_valid(letter)
    letter = letter.downcase

    if @word.include?(letter)
      return false if @guesses.include?(letter)
      @guesses += letter
    else
      return false if @wrong_guesses.include?(letter)
      @wrong_guesses += letter
    end
  end
  
  def word_with_guesses
    @word.gsub(/[^"#{@guesses}"]/, '-')
  end
  
  def check_win_or_lose
    return :win if @word.split('').sort.join == @guesses.split('').sort.join
    return :lose if @wrong_guesses.length == 7
    return :play
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
