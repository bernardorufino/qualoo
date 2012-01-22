# TIP: REMEMBER, when shit breaks, check for a consumers or salespeople
# in your database that has no user corresponding, or do this to just work
# Consumer.all.reject(&:user).each(&:destroy)
# Salesperson.all.reject(&:user).each(&:destroy)
class ApplicationController < ActionController::Base
  # TODO: Do the same as did in Consumer#show to Salesperson#show
  # TODO: Show users and salespeople relationed to each other, (The network)
  protect_from_forgery;
  
  def self.requires_authentication(opts={}, &block)
    user = opts.delete(:user) || opts.delete(:for);
    proc = Proc.new do |controller|
      block.call(controller) if block;
      controller.send(:method, :authenticate).call((user) ? {profile_type: user} : {});
    end
    before_filter(opts, &proc);    
  end
  
  protected
  def user_path(user, *args)
    user = User.find(user) if user.kind_of?(Fixnum);
    if user.profile
      send("#{user.profile_type.downcase}_path", user.profile,*args)
    else
      user_path(user, *args);
    end
  end
  
  def user_url(*args)
    request.protocol + request.host_with_port + user_path(*args);
  end
  
  helper_method :user_path, :user_url;
  
  def authenticate(opts={})
    if not logged_in?
      return access_denied(opts.merge(denial: :identity));
    elsif opts[:profile_type] and not current_user.profile?(opts[:profile_type])
      return access_denied(opts.merge(denial: :role));      
    end
    true;
  end
  
  def access_denied(opts)
    if opts[:denial] == :identity
      if opts[:profile_type]
        flash[:alert] = "Efetue login como #{friendly_profile_name(opts[:profile_type]).downcase} para acessar esse recurso.";
      else
        flash[:alert] = "Efetue login para acessar esse recurso.";
      end
      session[:redirect_path] = request.url;
      redirect_to login_path
    elsif opts[:denial] == :role
      flash[:alert] = "Voce nao tem permissao para acessar esse recurso."
      redirect_to page_path(:dashboard);
    end
    false;
  end
  
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
  
  def current_profile
    current_user.try(:profile);
  end
  
  helper_method :logged_in?, :current_user, :current_profile;
  
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
  
end
