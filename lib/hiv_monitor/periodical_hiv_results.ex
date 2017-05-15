defmodule HivMonitor.Worker do
  use GenServer
  use Hound.Helpers

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    state = fetch_firstplace_status()
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do

    res = fetch_firstplace_status()

    unless Map.equal?(state, res) do
      HivMonitor.Emails.status_email(res, state) |> HivMonitor.Mailer.deliver_now
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
end