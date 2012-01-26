class MessagesController < ApplicationController
  before_filter :filter_search, only: :search;
  requires_authentication;
  
  def search
    @messages = current_user.messages(@scope).search(params[:query]);
    msg = friendly_messages_scope(@scope, :plural => true).downcase;
    title "Pesquisando #{msg} por \"#{params[:query]}\"", :freeze => true;
    render :action => @scope;
  end
  
  def received
    @messages = current_user.received_messages;
  end
  
  def sent
    @messages = current_user.sent_messages;
  end
  
  def index
    redirect_to inbox_path;
  end
  
  def show
    @message = current_user.messages.find(params[:id]);
    @message.read!(current_user); 
  end
  
  def new
    @message = current_user.sent_messages.new;
  end
  
  def create
    @message = current_user.sent_messages.new(params[:message]);
    if @message.save
      flash[:notice] = "Mensagem enviada com sucesso!";
      redirect_to messages_path;
    else
      flash[:error] = "Mensagem em branco.";
      render :action => :new;
    end
  end  
  
  def destroy
    @message = current_user.received_messages.find(params[:id]);
    @message.destroy;
    flash[:info] = "Mensagem deletada."
    redirect_to :back;
  end
  
  protected
  def filter_search
    @scope = params[:messages].to_sym;
    @scope = :received unless [:sent, :received].include?(@scope);
  end
  
end
