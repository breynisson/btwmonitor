defmodule Fetch.Results do

  use Hound.Helpers

  def fetch_firstplace_status do
      Hound.start_session

      navigate_to("http://hjoladivinnuna.is/stadan/kilometrakeppni")
      el = find_element(:class, "first-place")
      spls = String.split(visible_text(el), " ")
      Enum.at(spls, 6) |> IO.puts()

      Hound.end_session
  end
  
end