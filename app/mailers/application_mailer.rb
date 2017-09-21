class ApplicationMailer < ActionMailer::Base
  default from: "my-bbq@heroku.com"
  layout 'mailer'
end
