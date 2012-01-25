# TIP: REMEMBER, when shit breaks, check for a consumers or salespeople
# in your database that has no user corresponding, or do this to just work
# Consumer.all.reject(&:user).each(&:destroy)
# Salesperson.all.reject(&:user).each(&:destroy)
class ApplicationController < ActionController::Base
  # TODO: OK Tags added to the network
  # TODO: OK Check the owner of resources as the current_user in ALL controllers
  # TODO: OK When default listing salespeople and consumers, check if current_user has him
  # and say that in the list, as well as the tag under which he has it
  # TODO: OK Separete by tags listings
  # TODO: DRY and refactorate: Eliminate current_profile and makes current_user act as current_profile
  
  protect_from_forgery;
  
  before_filter :reset_title;
  
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
  
  # When have time, implement this to accept a block and with capture, takes its content
  # and sets it to the h1, still holdng the *name* for the page title in browser
  def self.title(name=nil, opts={})
    if name.kind_of?(Hash)
      opts = name;
      name = nil;
    end
    @title = name if name and not title_frozen?;
    @title_frozen = true if opts.delete(:freeze);
    (title?) ? (opts.fetch(:prefix, "") + @title + opts.fetch(:suffix, "")) : "";
  end
  
  def self.title_frozen?
    !!@title_frozen;
  end
  
  def self.unfreeze
    @title_frozen = false;
  end
  
  def self.title?
    @title.present?;
  end
  
  def title(*args)
    self.class.title(*args);
  end
  
  def title?(*args)
    self.class.title?(*args);
  end
  
  helper_method :title, :title?;
  
  def reset_title
    title "";
    self.class.unfreeze;
  end
  
end
