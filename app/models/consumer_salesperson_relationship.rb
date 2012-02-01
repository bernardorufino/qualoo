class ConsumerSalespersonRelationship < ActiveRecord::Base
  include VisibilityControl;
  default_visibility :public;
  
  belongs_to :consumer;
  belongs_to :salesperson;
  belongs_to :visibility;
  has_many :relationship_taggings;
  has_many :tags, through: :relationship_taggings;
  
  validates :owner_type, presence: true, 
                         uniqueness: {scope: [:consumer_id, :salesperson_id]};
  
  def self.between(owner, target)
    # TODO: Optimize using queries
    owner.relationships.detect{|r| r.target == target};
  end
  
  # DEPRECATE!
  # A finder which finds the relationships between salespeople and consumers from certain consumer
  # or salesperson, determined by hash-like argument or an object, with the additional parameter
  # :owner, that, when defined, restricts the search to those relationships which the object
  # is the owner, when not specified, it ignores the owner. Examples:
  # 
  # Suppose the following relationships
  #    consumers 1, 2, 3
  #    salespeople 1, 2, 3
  #    consumer_salesperson_relationships 1 => [(1), 2], 2 => [2, (3)], 3 => [1, (3)]
  #    PS: [consumer_id, salesperson_id], in parenthesis the owner
  #
  #    ConsumerSalespersonRelationship.from :consumer => 1                         #=> [1]
  #    ConsumerSalespersonRelationship.from :consumer => 1, :owner => true         #=> [1]
  #    ConsumerSalespersonRelationship.from :consumer => 1, :owner => false        #=> []
  #    ConsumerSalespersonRelationship.from :salesperson => 1                      #=> []
  #    ConsumerSalespersonRelationship.from :salesperson => 2, :owner =>true       #=> []
  #    ConsumerSalespersonRelationship.from Salesperson.find(3), :owner => true    #=> [2, 3]
  #    ConsumerSalespersonRelationship.from Salesperson.find(3)                    #=> [2, 3]
  #    ConsumerSalespersonRelationship.from Salesperson.find(3), :owner => false   #=> []
  #
  # Note that
  #    ConsumerSalespersonRelationship.from Consumer.find(id), ...  
  # is the same as
  #    ConsumerSalespersonRelationship.from :consumer => id, ...  
  # 
  def self.from(opts, other_opts = {})
    opts = {opts.class.name.downcase.to_sym => opts.id} if opts.kind_of?(ActiveRecord::Base);
    opts = opts.merge(other_opts).symbolize_keys;
    # below, the last is the default
    type = (opts.key?(:salesperson)) ? :salesperson : (opts.key?(:consumer)) ? :consumer : :consumer;
    id = opts.delete(type).to_i;
    results = where "#{type}_id" => id;
    type = type.to_s.capitalize; 
    results = results.where :owner_type => type if opts[:owner];
    results = results.where ["owner_type <> ?", type] if opts[:owner] == false;
    results;
  end
  
  def tag?(tag)
    tags.include?(tag);
  end
  
  def owner
    send(owner_type.downcase);
  end
  
  def target
    send(owner.relates_with.downcase);
  end
  
end
