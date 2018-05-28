# frozen_string_literal: true

# Slack notification formatting: https://bit.ly/2LgtfLT
class SlackNotifier
  SLACK_WEBHOOK_URL = ENV.fetch("SLACK_CONTACT_WEBHOOK_URL")

  def call(message_type, options)
    return unless Rails.env.production?

    message = case message_type
              when :new_user
                new_user_message(options[:user])
              when :contact_us
                contact_us_message(options[:params])
              when :new_listing
                new_listing_message(options[:listing])
              end

    notifier = Slack::Notifier.new SLACK_WEBHOOK_URL do
      defaults channel: "#corner-messages", username: "Satoshi-Bot"
    end

    notifier.post(message)
  end

  def new_user_message(user)
    { text: "<!channel> Woot, a new user just signed up!",
      attachments: [
        {
          title: "Thats #{User.count} users signed up.",
          color: "#8db600",
          fields: [
            {
              title: "Display Name",
              value: user.display_name,
              short: true,
            },
            {
              title: "Email",
              value: user.email,
              short: true,
            },
          ],
        },
      ], }
  end

  def contact_us_message(params)
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

  def new_listing_message(listing)
    { text: "<!channel> Carlos says: " \
            "'Hey-Hey-Hey, a new listing was just posted!'",

      attachments: [
        {
          title: "Thats #{Listing.count} listings on the site.",
          color: "#4398BB",
          fields: [
            {
              title: "Listing Name",
              value: listing.name,
              short: true,
            },
            {
              title: "City, State",
              value: "#{listing.city}, #{listing.state}",
              short: true,
            },
            {
              title: "Currencies",
              value: listing.currencies.pluck(:name).join(", "),
              short: true,
            },
          ],
        },
      ], }
  end
end
