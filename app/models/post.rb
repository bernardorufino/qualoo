class Post < ActiveRecord::Base
  belongs_to :salesperson;
  has_many :likes;  
  
  validates_presence_of :salesperson, :body;
  
end
