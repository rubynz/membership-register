class MembershipConfirmation < Base
  def confirm
    member.confirm!
  end
end
