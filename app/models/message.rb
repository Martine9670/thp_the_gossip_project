class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :message_recipients
  has_many :recipients, through: :message_recipients, source: :user

  validates :content, presence: true
end