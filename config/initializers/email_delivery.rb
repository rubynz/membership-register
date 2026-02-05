smtp_username = ENV["SMTP_USERNAME"]
smtp_password = ENV["SMTP_PASSWORD"]

if smtp_username && smtp_password
  ActionMailer::Base.delivery_method = :smtp
  # See https://www.smtp2go.com/setupguide/rubyonrails/
  ActionMailer::Base.smtp_settings = {
    address: "mail-au.smtp2go.com",
    port: "2525",
    authentication: :plain,
    user_name: smtp_username,
    password: smtp_password,
    domain: "ruby.nz",
    enable_starttls_auto: true
  }
else
  warn "** SKIPPING SMTP CONFIGURATION"
end
