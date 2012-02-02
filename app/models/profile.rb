module Profile
  
  def self.included(klass)
    klass.send(:class_exec, &ClassEval)
    klass.extend(ClassMethods);
  end
  
  ClassEval = lambda do
    after_initialize :default_values;
    
  end
  
  module ClassMethods
    
    def search(*args)
      User.search(*args).where(profile_type: self.to_s).map(&:profile);
    end
    
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
  
  def location?
    location and location.public?;
  end

  protected
  def default_values
    self.avatar = Image.default(:avatar) if avatar.nil?;
  end
  
end