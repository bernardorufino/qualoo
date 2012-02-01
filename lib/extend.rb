class Array
  
  def to_sentence_with_br(opts={})
    to_sentence_without_br({two_words_connector: " e ", last_word_connector: ", e "}.merge(opts));
  end
  
  alias_method_chain :to_sentence, :br;
  
end
class Fixnum
  
  def count(zero, singular, plural)
    {self => plural}.merge(0 => zero, 1 => singular)[self].gsub("?", "#{self}");
  end
  
end
class Numeric
  
  # Geocoder compatibility
  def km
    Geocoder::Calculations.to_miles(self);
  end
  
  def to_km
    Geocoder::Calculations.to_kilometers(self);
  end
  
end