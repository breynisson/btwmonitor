defmodule Fetch.Results do

  use Hound.Helpers

  def fetch_firstplace_status do
      Hound.start_session

      navigate_to("http://hjoladivinnuna.is/stadan/kilometrakeppni")
      find_element(:class, "first-place")
      |> visible_text()
      |> String.split(" ")
      |> Enum.at(6)
      |> IO.puts()

      Hound.end_session
  end
  
end