class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel"
    stream_for current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	# current_user設定しないと使えない
  	Message.create!(body: data['message'], user_id: current_user.id, group_id: data['group'])
  end

end
