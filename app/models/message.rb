class Message < ApplicationRecord
	cattr_accessor :current
	after_create_commit { MessageBroadcastJob.perform_later(self) }
	belongs_to :group
	belongs_to :user
end
