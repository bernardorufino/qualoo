class Visibility < ActiveRecord::Base
  Main = [:public, :private];
  
  has_many :consumer_salesperson_relationships;
  
  validates_presence_of :name;
  validates :symbol, presence: true, uniqueness: true;
  
  def self.[](code)
    first(:conditions => {symbol: code.to_s});
  end
  
  Main.each do |code|
    define_singleton_method(code){self[code];};
    define_method(code.to_s + "?"){symbol == code;}; 
  end
  
  def symbol
    read_attribute(:symbol).to_sym;
  end
  
  def symbol=(sym)
    write_attribute(:symbol, sym.to_s);
  end
  
end
