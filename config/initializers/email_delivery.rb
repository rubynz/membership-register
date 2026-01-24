smtp_username = ENV["SENDGRID_USERNAME"]
smtp_password = ENV["SENDGRID_PASSWORD"]

if smtp_username && smtp_password
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: "587",
    authentication: :plain,
    user_name: smtp_username,
    password: smtp_password,
    domain: "heroku.com",
    enable_starttls_auto: true
  }
else
  warn "** SKIPPING SMTP CONFIGURATION"
end
