class StudentMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.send_assignment.subject
  #
  def send_assignment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
