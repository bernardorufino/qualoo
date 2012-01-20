class ApplicationController < ActionController::Base
# TODO: Implement page authorization, access denial to certain pages like Dashboard, 
# TODO: Review politics on editing User data (just can edit current_user's data)  
# TODO: ...
  
  protect_from_forgery;
  
  protected
  def login_user(user)
    session[:user_id] = @user.id;
    @current_user = user;
  end
    
  def logout_user
    reset_session;
    @current_user = nil;
  end
  
  def logged_in?
    session.key?(:user_id);
  end  
  
  def current_user
    return nil unless logged_in?;
    @current_user ||= User.find(session[:user_id]);
  end
  
  helper_method :logged_in?, :current_user;
  
  def self.title(name, opts={})
    @@title = name;
    @@title_frozen = opts.fetch(:freeze, false);
  end
  
  def self.title_frozen?
    (class_variable_defined?(:@@title_frozen)) ? @@title_frozen : false;
  end
  
  def title(name=nil, opts={})
    if name.kind_of?(Hash)
      opts = name;
      name = nil;
    end
    @@title = name.to_s if name and not self.class.title_frozen?;
    @@title_frozen = true if opts.delete(:freeze);
    result = (title?) ? @@title : "";
    (title?) ? (opts.fetch(:prefix, "") + result + opts.fetch(:suffix, "")) : "";
  end
  
  def title?
    self.class.send :class_variable_defined?, :@@title;
  end
  
  helper_method :title, :title?;
  
  def friendly_name(name, map, opts={})
    pick = (opts.fetch(:plural, false)) ? 1 : 0;
    prefix = opts.delete(:prefix) || "";
    suffix = opts.delete(:suffix) || "";
    prefix + map[name.to_s.downcase.to_sym][pick] + suffix;    
  end
  
  def friendly_profile_name(profile_type, *args)
    friendly_name(profile_type, {
      :salesperson => ["Revendedor(a)", "Revendedores(as)"],
      :consumer => ["Cliente", "Clientes"]
    }, *args);
  end
  
  helper_method :friendly_name, :friendly_profile_name;
  
end
