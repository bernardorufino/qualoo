module Profile
  
  def self.included(klass)
    klass.extend(ClassMethods);
  end
  
  def relationships
    consumer_salesperson_relationships;
  end
  
  def relationship_with(target)
    (relates_with?(target)) ? ConsumerSalespersonRelationship.between(self, target) : nil;
  end
  
  module ClassMethods
    
    def search(*args)
      User.search(*args).where(profile_type: self.to_s).map(&:profile);
    end
    
  end
  
end