class Member < ApplicationRecord

  before_create :set_joined_at
  after_create :reset_token!

  def reset_token!
    update! token: SecureRandom.hex, token_updated_at: Time.current
  end

  def join_date
    joined_at.to_date
  end

private

  def set_joined_at
    self.joined_at ||= Time.current
  end

end
