defmodule Fetch.Results do

  use Hound.Helpers

  def fetch_firstplace_status do
      Hound.start_session

      navigate_to("http://hjoladivinnuna.is/stadan/kilometrakeppni")
      resvalue = find_element(:class, "first-place")
                 |> visible_text()
                 |> String.split(" ")
#                 |> Enum.at(6)


      bs = byte_size("1.\n")
      <<_::binary-size(bs), resvalue_0::binary>> = Enum.at(resvalue, 0)
      team_name = resvalue_0 <> " "<> Enum.at(resvalue, 1)

      km = Enum.at(resvalue, 6)

      Hound.end_session

      res = %{:name => team_name, :km_value => km}
      res
  end
  
end