class Tag < ActiveRecord::Base
  has_many :relationship_taggings;
  has_many :consumer_salesperson_relationships, :through => :relationship_taggings;

end
