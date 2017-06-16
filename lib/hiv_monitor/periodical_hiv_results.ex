defmodule HivMonitor.Worker do
  use GenServer
  use Hound.Helpers

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    first = fetch_firstplace_status()
    second = fetch_secondplace_status()
    state = [first, second]
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do

    first = fetch_firstplace_status()
    second = fetch_secondplace_status()
    res = [first, second]

    unless Map.equal?((Enum.at(state, 0)), (Enum.at(res, 0))) do
      HivMonitor.Emails.status_email(Enum.at(res, 0), Enum.at(state, 0)) |> HivMonitor.Mailer.deliver_now
      IO.puts((DateTime.utc_now() |> DateTime.to_iso8601) <> ": " <> "Email Sent")
    end

    unless Map.equal?((Enum.at(state, 1)), (Enum.at(res, 1))) do
      HivMonitor.Emails.status_email_secondplace(Enum.at(res, 1), Enum.at(state, 1)) |> HivMonitor.Mailer.deliver_now
      IO.puts((DateTime.utc_now() |> DateTime.to_iso8601) <> ": " <> "Email Sent")
    end

    IO.puts((DateTime.utc_now() |> DateTime.to_iso8601) <> ": " <> "A loop completed...")
    schedule_work()
    {:noreply, res}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 5 * 60 * 1000) # In 5 min
  end

  defp fetch_firstplace_status do
      Hound.start_session

      navigate_to("http://hjoladivinnuna.is/stadan/kilometrakeppni")
      resvalue = find_element(:class, "first-place")
                 |> visible_text()
                 |> String.split(" ")


      bs = byte_size("1.\n")
      <<_::binary-size(bs), resvalue_0::binary>> = Enum.at(resvalue, 0)
      team_name = resvalue_0 <> " "<> Enum.at(resvalue, 1)

      km = Enum.at(resvalue, 6)

      Hound.end_session

      res = %{:name => team_name, :km_value => km}
      res
  end


  defp fetch_secondplace_status do
     Hound.start_session

     navigate_to("http://hjoladivinnuna.is/stadan/kilometrakeppni")
     trelements = find_element(:class, "table-responsive")
                  |> find_all_within_element(:tag, "tr")


     secondplace = Enum.at(trelements, 2) |> visible_text() |> String.split(" ")
     team_name = Enum.at(secondplace, 1) <> " "<> Enum.at(secondplace, 2)
     km = Enum.at(secondplace, 7)

     Hound.end_session

     res = %{:name => team_name, :km_value => km}
     res
  end
end