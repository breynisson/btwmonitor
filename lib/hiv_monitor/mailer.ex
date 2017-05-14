defmodule HivMonitor.Mailer do
  use Bamboo.Mailer, otp_app: :hiv_monitor
end

# Define your emails
defmodule HivMonitor.Emails do
  import Bamboo.Email

  def welcome_email do

    new_email
    |> to("bjorgvin.reynisson@gmail.com")
    |> from("postmaster@sandboxceff553e43ed43e88033432300ccdd75.mailgun.org")
    |> subject("Hjolad i Vinnuna: Update on 1. place km.")
    |> html_body("<strong>You can check the updated status at the hjolad i vinnuna page!</strong>")
    |> text_body("You can check the updated status at the hjolad i vinnuna page!")
  end
end