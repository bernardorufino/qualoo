class Visibility < ActiveRecord::Base
  has_many :consumer_salesperson_relationships;
  
  def symbol
    read_attribute(:symbol).to_sym;
  end
  
  def symbol=(sym)
    write_attribute(:symbol, sym.to_s);
  end
  
  [:public, :private].each do |code|
    define_method(code.to_s + "?"){symbol == code;}; 
  end
  
end
