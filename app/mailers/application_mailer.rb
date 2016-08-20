class ApplicationMailer < ActionMailer::Base
  default(
    from: '"Ruby New Zealand <robot@ruby.nz>',
    reply_to: 'secretary@ruby.nz',
  )
  layout 'mailer'
end
