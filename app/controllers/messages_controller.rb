class MessagesController < ApplicationController

	def index
		@messages = Message.all.order(created_at: 'DESC')
	end
end
