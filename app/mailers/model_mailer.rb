class ModelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
  default_url_options[:host] = "localhost:3000"
  default from: "foo@sandbox4a4795ac43e94b6696cc0d303a274da5.mailgun.org"

  def new_record_notification(user)
    @user = user
    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>",
         subject: "Reset Your Password On DOTO."
  end

  def todo_list(todo_list, destination)
    @user = todo_list.user
    @todo_list = todo_list
    mail(to: destination, subject: "#{@user.first_name} sent you a todo list")
  end
end
