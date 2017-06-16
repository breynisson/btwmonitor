defmodule HivMonitor.Mailer do
  use Bamboo.Mailer, otp_app: :hiv_monitor
end

# Define your emails
defmodule HivMonitor.Emails do
  import Bamboo.Email

  def welcome_email do

    new_email()
    |> to("bjorgvin.reynisson@gmail.com")
    |> from("postmaster@sandboxceff553e43ed43e88033432300ccdd75.mailgun.org")
    |> subject("Hjolad i Vinnuna: Update on 1. place km.")
    |> html_body("<strong>You can check the updated status at the hjolad i vinnuna page!</strong>")
    |> text_body("You can check the updated status at the hjolad i vinnuna page!")
  end

  def status_email(new_status, old_status) do

    new_st_name = new_status[:name]
    new_st_km = new_status[:km_value]

    old_st_name = old_status[:name]
    old_st_km = old_status[:km_value]

    {new_km, _} = new_st_km |> String.replace(".", "") |> String.replace(",", ".") |> Float.parse()
    {old_km, _} = old_st_km |> String.replace(".", "") |> String.replace(",", ".") |> Float.parse()
    km_diff = new_km - old_km |> Float.round(2) |> to_string()


    new_email()
    |> to(["bjorgvin.reynisson@gmail.com", "esth@ccpgames.com", "snorri.sturluson@ccpgames.com"])
    |> from("postmaster@sandboxceff553e43ed43e88033432300ccdd75.mailgun.org")
    |> subject("Hjolad i Vinnuna: Update on 1. place km.")
    |> text_body("You can check the updated status at the hjolad i vinnuna page!

    Old status was: #{old_st_name}, #{old_km}.
    New status is: #{new_st_name}, #{new_km}.
    Difference is: #{km_diff}.")
  end

  def status_email_secondplace(new_status, old_status) do

    new_st_name = new_status[:name]
    new_st_km = new_status[:km_value]

    old_st_name = old_status[:name]
    old_st_km = old_status[:km_value]

    {new_km, _} = new_st_km |> String.replace(".", "") |> String.replace(",", ".") |> Float.parse()
    {old_km, _} = old_st_km |> String.replace(".", "") |> String.replace(",", ".") |> Float.parse()
    km_diff = new_km - old_km |> Float.round(2) |> to_string()


    new_email()
    |> to(["bjorgvin.reynisson@gmail.com"])
    |> from("postmaster@sandboxceff553e43ed43e88033432300ccdd75.mailgun.org")
    |> subject("Hjolad i Vinnuna: Update to second place!")
    |> text_body("You can check the updated status at the hjolad i vinnuna page!
    Old status was: #{old_st_name}, #{old_km}.
    New status is: #{new_st_name}, #{new_km}.
    Difference is: #{km_diff}.")
  end

end