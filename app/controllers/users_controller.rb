# frozen_string_literal: true

class UsersController < ApplicationController
  CONTACT_US_WEBHOOK_URL = ENV.fetch("SLACK_CONTACT_WEBHOOK_URL")

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Much Wow. Account created"
      redirect_to listings_path
    else
      render :new
    end
  end

  # Contact Us Page
  def contact; end

  # Recieves message from Contact Us page
  def message
    notifier = Slack::Notifier.new CONTACT_US_WEBHOOK_URL do
      defaults channel: "#corner-messages", username: "https://corner-pay.com/contact"
    end

    if notifier.post slack_formatted_message
      flash[:success] = "We've notified a real person. " \
                      "Hodl tight and we'll get back to you."
    else
      flash[:danger] = "Something has gone horribly wrong. " \
                      "You're message was not sent. " \
                      "We'd say to get a hold of us through the contact form, "\
                      "but........."
    end

    redirect_to contact_path
  end

  private

  # Slack notification formatting: https://bit.ly/2LgtfLT
  def slack_formatted_message
    { text: "<!channel> Heads Up!",
      attachments: [
        {
          title: "Someone wants to get a hold of us.",
          fields: [
            {
              title: "Name",
              value: params[:name],
              short: true,
            },
            {
              title: "Email",
              value: params[:email],
              short: true,
            },
            {
              title: "Message",
              value: params[:message],
              short: false,
            },
          ],
        },
        {
          text: "Let's email them back so they " \
                "know we are paying attention.",
          color: "#3AA3E3",
          title: "Next Steps:",
        },
      ], }
  end

  PERMITTED_PARAMS = [
    :display_name,
    :email,
    :password,
    :password_confirmation,
  ].freeze

  def user_params
    params.require(:user).permit(*PERMITTED_PARAMS).merge(role: "user")
  end
end
