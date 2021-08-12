class VoteRequestsController < ApplicationController
  before_action :verify_voting_enabled

  def new
  end

  def create
    member = Member.find_by(email: params.require(:email))

    if member
      MembershipMailer.vote_request(member).deliver_now
    else
      # Simulate a small delay to prevent membership disclosure via timing
      # attacks.
      sleep rand(0.1..0.3)
    end
  end

  private

  def verify_voting_enabled
    return if helpers.voting_enabled?
    raise 'Voting not enabled'
  end
end
