module ParentBehavior
  
  def self.included(klass)
    klass.extend ClassMethods;
  end
  
  def method_missing_with_user_inheritance(method, *args, &block)
    child = class.children.detect{|child| send(child).respond_to?(method);};
    return send(child).send(method, *args, &block) if child;
    method_missing_without_user_inheritance(method, *args, &block);    
  end
  
  alias_method_chain :method_missing, :user_inheritance;
  
  def respond_to_with_user_inheritance?(method, *args)
    respond_to_without_user_inheritance?(method, *args) or class.children.any?{|child| send(child).respond_to?(method, *args);};
  end
  
  alias_method_chain :respond_to?, :user_inheritance;
  
  module ClassMethods
    
    def children; @children; end
    
    def parent_of(child, opts={})
      child = child.to_sym;
      (@children ||= []) << child;
      belongs_to(child, {
        polymorphic: true, 
        dependent: :destroy, 
        autosave: true, 
        touch: true, 
        validated: true
      }.merge(opts));      
    end
    
  end
  
end

module ChildBehavior

  def self.included(klass)
    klass.extend ClassMethods;
  end
  
  def parent
    (class.parent) ? send(class.parent) : nil;
  end
  
  def method_missing_with_user_behavior(method, *args, &block)
    if parent and parent.respond_to?(method);
      parent.send(method, *args, &block)
    else method_missing_without_user_behavior(method, *args, &block); end  
  end
  
  alias_method_chain :method_missing, :user_behavior;
  
  def respond_to_with_user_behavior?(method, *args)
    respond_to_without_user_behavior?(method, *args) or user.respond_to?(method, *args);
  end
  
  alias_method_chain :respond_to?, :user_inheritance;
  
  module ClassMethods
    
    def parent; @parent; end
    
    def is_one(parent, opts={})
      @parent = parent.to_sym;
      has_one(@parent, {
        dependent: :destroy,
        autosave: true,
        validate: true
      }.merge(opts));
    end  
    
  end
    
end