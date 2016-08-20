class MembershipInquiry
  include ActiveModel::Model

  attr_accessor :email

  validates_presence_of :email
  validate :must_be_valid_email

  def deliver_email
    return unless valid?
    member.update! token: SecureRandom.hex, token_updated_at: Time.current
    MembershipMailer.inquiry(member).deliver_now
  end

private

  def must_be_valid_email
    errors.add(:email, :cannot_be_found) unless member.present?
  end

  def member
    @member ||= Member.find_by email: email
  end
end
