class MembershipInquiriesController < ApplicationController
  respond_to :html

  def new
    @inquiry = MembershipInquiry.new
  end

  def create
    @inquiry = MembershipInquiry.new(inquiry_params)
    @inquiry.deliver_email
    respond_with @inquiry, location: :membership_inquiry
  end

  private

  def inquiry_params
    params.require(:membership_inquiry).permit(:email)
  end
end
