class ApplicationMailer < ActionMailer::Base
  default(
    from: '"Ruby NZ Membership Service" <membership-robot@ruby.nz>',
    reply_to: 'secretary@ruby.nz',
  )
  layout 'mailer'
end
