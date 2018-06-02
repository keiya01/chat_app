class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel"
    stream_for current_group.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	# current_user設定しないと使えない
    p "TEST#{data['user_id']}"
  	Message.create!(body: data['message'], user_id: data['user_id'].to_i, group_id: data['group'].to_i)
  end

end
