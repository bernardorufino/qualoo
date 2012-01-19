class Post < ActiveRecord::Base
  belongs_to :salesperson;
  has_many :likes;  
  
end
