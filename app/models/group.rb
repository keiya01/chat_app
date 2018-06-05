class Group < ApplicationRecord
	validate :add_presence_errors
	validates :name, length: {minimum: 3}
	validates :entry_pass, uniqueness: {message: '送信ボタンを押してください'}
	has_many :users, dependent: :destroy
	has_many :messages, dependent: :destroy

	def add_presence_errors
		if name.empty?
			errors.add(:name, "を入力してください！")
		end
	end

end
