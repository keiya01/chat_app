class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	group = message.group_id
  	puts "TEST:#{message}"
    RoomChannel.broadcast_to(group, message: render_message(message))
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end

end
