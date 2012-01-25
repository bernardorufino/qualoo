class Array
  
  def to_sentence(opts={})
    super({two_words_connector: " e ", last_word_connector: ", e "}.merge(opts));
  end
  
end