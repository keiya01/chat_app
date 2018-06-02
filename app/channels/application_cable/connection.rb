module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_group

   def connect
     self.current_group = find_verified_group
   end

   protected

   def find_verified_group
     if verified_group = Group.find_by(entry_pass: session['group_id'])
       verified_group
     else
       reject_unauthorized_connection
     end
   end

   def session
     cookies.encrypted[Rails.application.config.session_options[:key]]
   end
 end

  end
