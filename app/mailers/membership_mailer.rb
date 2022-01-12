class MembershipMailer < ApplicationMailer
  helper ApplicationHelper

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.membership_mailer.inquiry.subject
  #
  def inquiry(member)
    @member = member
    mail to: @member.email
  end

  def vote_request(member)
    @member = member
    @vote_url = Rails.configuration.vote_url_template.sub('%token%', @member.voting_token)
    mail to: @member.email
  end

  def confirm(member)
    @member = member
    mail to: @member.email
  end
end
