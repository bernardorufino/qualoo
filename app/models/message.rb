class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User";
  belongs_to :recipient, class_name: "User"; 
  
  default_scope order("created_at DESC");
  
  validates_presence_of :sender, :recipient, :body;
  
  after_initialize :default_values;
  
  def self.search(query)
    where(["body LIKE ?", "%#{query}%"]);
  end
  
  def self.from(*args)
    if [:sent_messages, :received_messages, :id].all?{|m| args.first.respond_to?(m)}
      where(["recipient_id = :id OR sender_id = :id", {id: args.first.id}]).order("created_at DESC");
    else super(*args); end
  end
  
  def sender?(user)
    sender == user;
  end
  
  def recipient?(user)
    recipient == user;
  end
  
  def read?
    !!read;
  end
  
  def read!(user)
    self.read = true if recipient?(user);
    save;
  end
  
  def self?(user=nil)
    (user) ? (recipient == sender && sender == user) : (recipient == sender);
  end
  
  protected
  def default_values
    self.read = false if read.nil?;
  end
  
  
end
