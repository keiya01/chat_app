class Group < ApplicationRecord
	validate :add_presence_errors
	validates :name, length: {minimum: 3}
	validates :name_id, length: {minimum: 5}, uniqueness: {message: 'はすでに使われています。'}, format: { with: /\A[a-z0-9]+\z/i, message: 'は半角英数字で入力してください。'}
	validates :password_digest, length: {minimum: 5}
	validates :entry_pass, uniqueness: {message: '送信ボタンを押してください'}
	has_secure_password
	has_many :users, dependent: :destroy
	has_many :messages, dependent: :destroy

	def add_presence_errors
		if name.empty?
			errors.add(:name, "を入力してください！")
		elsif name_id.empty?
			errors.add(:name_id, "を入力してください！")
		end
	end

end
