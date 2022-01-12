class MembershipInquiry < Base
  def deliver_email
    return unless valid?
    member.reset_token!
    MembershipMailer.inquiry(member).deliver_now
  end
end
