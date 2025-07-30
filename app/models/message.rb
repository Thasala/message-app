class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, optional: true
  belongs_to :chatroom, optional: true
  after_initialize :set_defaults

  validates :body, presence: true

  scope :custom_display, -> { order(:created_at).last(10) }

  def set_defaults
    self.read = false if self.read.nil?
  end
end
