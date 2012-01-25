class Category < ActiveRecord::Base
  has_and_belongs_to_many :companies;
  
  validates_presence_of :name;
  
  def self.search(query)
    where(["name LIKE ?", "%#{query}%"]);    
  end
  
end
