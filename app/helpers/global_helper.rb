module GlobalHelper
  protected
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
  
  def to_profile(obj)
    try_profile_type(obj).to_s.classify.constantize;
  end
  
  def to_profile_name(obj)
    try_profile_type(obj).to_s.classify;
  end
  
  def to_profile_sym(obj)
    try_profile_type(obj).to_s.downcase.to_sym
  end
  
  def try_profile_type(obj)
    (obj.respond_to?(:profile_type)) ? obj.profile_type : obj;
  end
  
end

[ActionView::Base, ActiveRecord::Base, ActionController::Base].each do |klass|
  klass.send(:include, GlobalHelper);
end
