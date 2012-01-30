require "digest";

class User < ActiveRecord::Base
  include ParentBehavior;  

  parent_of :profile;
  belongs_to :location;
  has_many :sent_messages, order: "created_at DESC", class_name: "Message", foreign_key: :sender_id;
  has_many :received_messages, order: "created_at DESC", class_name: "Message", foreign_key: :recipient_id;
  has_many :measurements_done, class_name: "Measurement", foreign_key: :measurer_id;
  has_many :likes;
  has_many :tags;
  
  attr_accessor :password;
  
  validates_presence_of :profile_type;
  validates :email, presence: true,
                    uniqueness: true,
                    format: {with: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i};
  validates :password, presence: true,
                      confirmation: true,
                      if: :password_validation_needed?;
  validates :first_name, presence: true;
  
  before_save :set_profile, :encrypt_new_password;
  after_validation :set_password_confirmation_error;
  
  scope :salespeople, where(profile_type: "Salesperson");
  scope :consumers, where(profile_type: "Consumer");
  
  def self.search(query)
    where([
      "first_name LIKE :query OR last_name LIKE :query", 
      {query: "%#{query}%"}
    ]); 
  end
  
  def self.find_by_profile(profile_type)
    profile_type = profile_type.to_s.classify;
    return all unless profile_type?(profile_type);
    where(profile_type: profile_type);
  end
  
  def self.profile_types
    ["Consumer", "Salesperson"];
  end
  
  def self.profile_type?(profile_type)
    return false unless profile_type;
    profile_types.include?(profile_type.to_s.classify);
  end
  
  def self.authenticate(email, password);
    user = User.find_by_email(email);
    return (user and user.authentic?(password)) ? user : nil;
  end  
  
  def messages(type=nil)
    #(sent_messages + received_messages).sort_by(&:created_at).reverse;
    if type and type.to_sym == :receveid then received_messages;
    elsif type and type.to_sym == :sent then sent_messages;
    else Message.from(self); end
  end
  
  def unread_messages
    received_messages.where(:read => false);
  end
  
  def can_relate_with?(user)
    profile and profile_type == user.profile.relates_with;
  end
  
  def name
    (first_name and last_name) ? "#{first_name} #{last_name}" : first_name;
  end
   
  def profile?(type)
    (profile or (new_record? and profile_type)) ? (profile_type.downcase == type.to_s.downcase) : nil;
  end 
   
  def authentic?(password)
    password_hash == encrypt(password);
  end
  
  def consumer?; profile?(:consumer); end
  def salesperson?; profile?(:salesperson); end
  
  # Implement something else!
  def admin?
    ["bermonruf@gmail.com", "rodolfo.pinotti@gmail.com"].include?(email);
  end
  
  protected
  def set_profile
    if new_record? and not profile
      self.profile = profile_type.classify.constantize.create({});
    end
  end
  
  def encrypt_new_password
    self.password_hash = encrypt(@password) if @password.present?;  
  end
  
  def encrypt(string)
    Digest::SHA1.hexdigest(string);
  end
  
  def password_validation_needed?
    password_hash.blank? or @password.present?;
  end
  
  def set_password_confirmation_error
    message = "doesn't match confirmation";
    errors.add(:password_confirmation, "does't match") if !errors[:password].nil? and errors[:password].any?
    errors[:password].replace([]) if errors[:password] == [message];
  end
  
end

