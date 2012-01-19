class User < ActiveRecord::Base
  include ParentBehavior;  

  parent_of :profile;
    
  belongs_to :location;
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id;
  has_many :received_messages, class_name: "Message", foreign_key: :recipient_id;
  has_many :measurements_done, class_name: "Measurement", foreign_key: :measurer_id;
  has_many :measurements_received, class_name: "Measurement", foreign_key: :measured_id;
  has_many :likes;
  
  
end

