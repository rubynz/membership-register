class MembershipConfirmation < Base
  def confirm
    return unless valid?
    member.confirm!
  end
end
