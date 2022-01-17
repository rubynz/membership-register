class MembershipConfirmationsController < ApplicationController

  respond_to :html

  def new
    @confirm = MembershipConfirmation.new
  end

  def create
    @confirm = MembershipConfirmation.new(confirmation_params)
    @confirm.confirm
    respond_with @confirm, location: :membership_confirmation
  end

private

  def confirmation_params
    params.require(:membership_confirmation).permit(:email)
  end
end
