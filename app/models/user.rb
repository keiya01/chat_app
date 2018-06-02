class User < ApplicationRecord
	validates :name, length: {minimum: 3}
	validate :add_presence_errors
	has_many :messages, dependent: :destroy

	def add_presence_errors
		if name.empty?
			errors.add(:name, "を入力してください！")
		end
	end


end
