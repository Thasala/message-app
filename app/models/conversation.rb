# app/models/conversation.rb
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, -> (sender_id, recipient_id) do
    where(
      "(conversations.sender_id = :s AND conversations.recipient_id = :r) OR 
       (conversations.sender_id = :r AND conversations.recipient_id = :s)",
      s: sender_id, r: recipient_id
    )
  end

  def other_user(current_user)
    # Make sure we're comparing user IDs directly
    current_user.id == sender_id ? recipient : sender
  end
end
