class Member < ApplicationRecord
  validates_presence_of :full_name, :email, :address
  validates_uniqueness_of :full_name, if: :full_name_changed?
  validates_uniqueness_of :email, if: :email_changed?

  before_create :set_joined_at

private

  def set_joined_at
    self.joined_at ||= Time.current
  end
end
