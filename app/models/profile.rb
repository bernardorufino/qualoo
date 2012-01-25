module Profile
  
  def self.included(klass)
    klass.extend(ClassMethods);
  end
  
  def relationships
    consumer_salesperson_relationships;
  end
  
  def relationship_with(target)
    target = target.profile;
    (relates_with?(target)) ? ConsumerSalespersonRelationship.between(self, target) : nil;
  end
  
  def new_target
    send(to_profile_sym(relates_with, plural: true)).new;
  end
  
  module ClassMethods
    
    def search(*args)
      User.search(*args).where(profile_type: self.to_s).map(&:profile);
    end
    
  end
  
end