class Visibility < ActiveRecord::Base
  Main = [:public, :private];
  
  has_many :consumer_salesperson_relationships;
  
  validates_presence_of :name;
  validates :symbol, presence: true, uniqueness: true;
  
  Main.each do |code|
    define_singleton_method(code){first(:conditions => {symbol: code.to_s});};
    define_method(code.to_s + "?"){symbol == code;}; 
  end
  
  def symbol
    read_attribute(:symbol).to_sym;
  end
  
  def symbol=(sym)
    write_attribute(:symbol, sym.to_s);
  end
  
end
