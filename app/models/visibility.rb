class Visibility < ActiveRecord::Base
  has_many :consumer_salesperson_relationships;
  
  validates_presence_of :name;
  validates :symbol, presence: true, uniqueness: true;
  
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
