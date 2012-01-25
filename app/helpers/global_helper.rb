module GlobalHelper
  protected
  def manage_relationships_path(*args)
    send({
      :salesperson => :salesperson_consumers_path,
      :consumer => :consumer_salespeople_path
    }[to_profile_sym(current_profile)], current_profile, *args);
  end
  
  def manage_relationships_path?(*args)
    manage_relationships_path(*args) == request.fullpath;
  end
  
  def friendly_name(name, map, opts={})
    pick = (opts.fetch(:plural, false)) ? 1 : 0;
    prefix = opts.delete(:prefix) || "";
    suffix = opts.delete(:suffix) || "";
    prefix + map[name.to_s.downcase.to_sym][pick] + suffix;    
  end
  
  def friendly_profile_name(profile_type, *args)
    profile_type = profile_type.profile_type if profile_type.respond_to?(:profile_type);
    friendly_name(profile_type, {
      :salesperson => ["Revendedor", "Revendedores"],
      :consumer => ["Cliente", "Clientes"]
    }, *args);
  end
  
  def to_profile(obj, *args)
    try_profile_type(obj, *args).to_s.classify.constantize;
  end
  
  def to_profile_name(obj, *args)
    try_profile_type(obj, *args).to_s.classify;
  end
  
  def to_profile_sym(obj, *args)
    try_profile_type(obj, *args).to_s.downcase.to_sym
  end
  
  def try_profile_type(obj, opts={})
    obj = obj.profile_type if obj.respond_to?(:profile_type);
    (opts.delete(:plural)) ? obj.pluralize : obj;
  end
  
end

[ActionView::Base, ActiveRecord::Base, ActionController::Base].each do |klass|
  klass.send(:include, GlobalHelper);
end
