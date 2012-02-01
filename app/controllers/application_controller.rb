# TIP: REMEMBER, when shit breaks, check for a consumers or salespeople
# in your database that has no user corresponding, or do this to just work
# Consumer.all.reject(&:user).each(&:destroy)
# Salesperson.all.reject(&:user).each(&:destroy)
class ApplicationController < ActionController::Base
  # TODO: Implement a helper use_original_user_path to be added to the pages or actions in which
  # we need to use the original user_path, instead of the list in the method, check user_path below
  # TODO: When implement Geocoder, include visibility_id in Location!
  # TODO: OK Check to_sentence method to write in portuguese by default with /lib/array.rb, in companies_helper 
  # TODO: DRY and refactorate: Eliminate current_profile and makes current_user act as current_profile
  # TODO: Unify icons for resources
  
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
  def welcome_user
    flash[:notice] = "Bem vindo, #{current_profile.first_name}!";
    redirect_to page_path(:dashboard);
  end
  
  def user_path_with_profile(user, *args)
    user = User.find(user) if user.kind_of?(Fixnum);
    original_use_paths = [
      user_path_without_profile(params[:id]), 
      edit_user_path(params[:id]), 
      new_user_path(params[:id])
    ];
    if user.profile and not original_use_paths.include?(request.path)
      send("#{user.profile_type.downcase}_path", user.profile,*args)
    else
      user_path_without_profile(user, *args);
    end
  end
  
  alias_method_chain :user_path, :profile
  
  def user_url(*args)
    request.protocol + request.host_with_port + user_path(*args);
  end
  
  helper_method :user_path, :user_url;
  
  def authenticate(opts={})
    if not logged_in?
      return access_denied(opts.merge(denial: :identity));
    elsif User.profile_type?(opts[:profile_type]) and not current_user.profile?(opts[:profile_type])
      return access_denied(opts.merge(denial: :role));      
    elsif opts[:profile_type] == :admin and not current_user.admin?
      return access_denied(opts.merge(denial: :role));
    end
    true;
  end
  
  def access_denied(opts)
    if opts[:denial] == :identity
      if User.profile_type?(opts[:profile_type])
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
  
  def current_user?(user_or_profile)
    return false unless logged_in?;
    user_or_profile == ((user_or_profile.is_a?(User)) ? current_user : current_profile);
  end
  
  helper_method :logged_in?, :current_user, :current_profile, :current_user?;
  
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
