class Salesperson < ActiveRecord::Base
  include ChildBehavior;
  include Profile;
  
  has_one :location, as: :localizable;
  is_one :user, as: :profile;
  has_many :consumer_salesperson_relationships, conditions: {owner_type: "Salesperson"};
  has_many :consumers, through: :consumer_salesperson_relationships;
  has_many :posts, order: "created_at DESC";
  has_many :company_salesperson_contracts;
  has_many :companies, through: :company_salesperson_contracts;
  has_many :measurements_received, class_name: "Measurement", foreign_key: :measured_id;
  
  def rank(level, user)
    return nil if self.user == user;
    m = measurements_received.find_or_create_by_measurer_id(user.id);
    m.level = level;
    m.save!;
    m;
  end
  
  def rank_level
    (measurements_received.sum(&:level) / measurements_received.size).round rescue nil;
  end
  
  def rank_level_by(user)
    measurements_received.find_by_measurer_id(user.id).try(:level);
  end
  
  def ranked?(level, user)
    rank_level_by(user) == level;
  end
  
  def ranks
    measurements_received.size;
  end  
  
  def relates_with
    "Consumer"
  end
  
  def relates_with?(consumer)
    consumers.include?(consumer.try(:profile));
  end
  
  def custumers
    relationships.select(&:public?).map(&:consumer);
  end

  def from?(company)
    companies.include?(company);
  end

end