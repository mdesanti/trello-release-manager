class EmailsController < ApplicationController

  def send_email
    Mailer.notify_release(params).deliver
    redirect_to root_url
  end
end
