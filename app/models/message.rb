class Message < ApplicationRecord
	session = Thread.current[:request].session ? Thread.current[:request].session : ""
	after_create_commit { MessageBroadcastJob.perform_later(self, session[:user_id]) }
	belongs_to :group
	belongs_to :user
end
