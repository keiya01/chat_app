class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, user)
  	group = message.user_id
    RoomChannel.broadcast_to(group, message: render_message(message, user))
  end

  private
    def render_message(message, user)
      # user = User.find(user_id)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, user: user })
    end

end
