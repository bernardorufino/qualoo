module ParentBehavior
  
  def self.included(klass)
    klass.extend ClassMethods;
  end
  
  module ClassMethods
    
    def parent_of(child, opts={})
      belongs_to(child.to_sym, {
        polymorphic: true, 
        dependent: :destroy, 
        autosave: true, 
        touch: true, 
        validate: true
      }.merge(opts));      
    end
    
  end
  
end