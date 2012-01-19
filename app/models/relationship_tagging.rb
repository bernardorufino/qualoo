class RelationshipTagging < ActiveRecord::Base
  belongs_to :consumer_salesperson_relationship;
  belongs_to :tag;
  
end
