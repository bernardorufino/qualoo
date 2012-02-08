class Guest < ActiveRecord::Base
  validates :email, presence: true,
                    uniqueness: true,
                    format: {with: /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i};
  validates_presence_of :name, :city;
 
  after_initialize :default_values;
 
 
  protected
  def default_values
    write_attribute(:profile_type, "Salesperson") unless profile_type;
  end 
 
end
