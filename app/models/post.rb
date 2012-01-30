class Post < ActiveRecord::Base
  belongs_to :salesperson;
  has_many :likes;  
  
  validates_presence_of :salesperson, :body;
  
  def nlikes
    likes.size;
  end
  
  def users_liked
    likes.map(&:user);
  end
  
  def like(user)
    likes.find_or_create_by_user_id(user.id);
  end
  
  def unlike(user)
    like(user).destroy if liked?(user);
  end
  
  def liked?(user)
    !!likes.find_by_user_id(user.id);
  end
  
end

