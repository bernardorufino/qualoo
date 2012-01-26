module MessagesHelper

  def message_search_scopes
    {
      "Enviadas" => "sent", 
      "Recebidas" => "received"
    };
  end

  def unread_messages_header
    current_user.unread_messages.size.count("", "(?)", "(?)");
  end

  def message_row_class(message)
    (message.recipient?(current_user) and not message.read?) ? "unread" : nil;    
  end

  def message_icon(message)
    if message.self?(current_user)
      (request.path == sent_messages_path) ? icon("email_go") : ((message.read?) ? icon("email_open") : icon("email"));     
    elsif message.sender?(current_user)
      icon("email_go");
    elsif message.read?
      icon("email_open");
    else
      icon("email");      
    end
  end

  def users_as_options
    options_for_select(User.all.map{|u| ["#{friendly_profile_name(u)} #{u.name}", u.id];});
  end

end
