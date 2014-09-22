class Mailer < ActionMailer::Base
  default from: "releases@wolox.com.ar"

  def notify_release(args={})
    @trello_release = TrelloRelease.find(args[:trello_release])
    @body = args[:intro]
    mail(to: args[:to], from: args[:from], subject: args[:subject])
  end
end
