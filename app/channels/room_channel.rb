class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from current_user.id
    stream_for current_user.group_id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	# current_user設定しないと使えない
  	Message.create!(body: data['message'], user_id: data['user_id'], group_id: data['group'])
  end

end
