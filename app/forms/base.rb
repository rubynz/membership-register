class Base
  include ActiveModel::Model

  attr_accessor :email

  validates_presence_of :email
  validate :must_be_valid_email

private

  def must_be_valid_email
    errors.add(:email, :cannot_be_found) unless member.present?
  end

  def member
    @member ||= Member.find_by email: email
  end
end
