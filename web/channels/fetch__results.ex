defmodule Fetch.Results do

  use Hound.Helpers

  def fetch_firstplace_status do
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

  def fetch_secondplace_status do
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