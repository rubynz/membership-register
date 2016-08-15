class Member < ApplicationRecord
  validates_presence_of :full_name, :email, :address

  before_create :set_joined_at

private

  def set_joined_at
    self.joined_at ||= Time.current
  end
end
