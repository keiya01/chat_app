class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, user_id)
  	group = message.group_id
    RoomChannel.broadcast_to(group, message: render_message(message, user_id))
  end

  private
    def render_message(message, user_id)
      message.user_id = user_id
      message.save
      user = User.find(user_id)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, user: user })
    end

end
