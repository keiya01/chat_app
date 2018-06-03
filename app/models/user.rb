class User < ApplicationRecord
	validates :name, presence: true
	validates :nickname, format: { with: /\A[a-z0-9]+\z/i, message: 'は半角英数字で入力してください。', allow_blank: true }, 
	uniqueness: {message: 'はすでに使用されています。', allow_blank: true}, length: {minimum: 3, allow_blank: true}
	has_secure_password
	validate :add_presence_errors
	has_many :messages, dependent: :destroy

	def add_presence_errors
		if name.empty?
			errors.add(:name, "を入力してください！")
		end
	end


end
