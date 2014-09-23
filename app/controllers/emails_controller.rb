class EmailsController < ApplicationController

  def send_email
    Mailer.notify_release(params).deliver
    render json: {}, status: 200
  end
end
