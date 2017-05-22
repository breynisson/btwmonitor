defmodule HivMonitor.PageController do
  use HivMonitor.Web, :controller

  alias Fetch.Results

  def index(conn, _params) do
    res = Results.fetch_firstplace_status()
    sec = Results.fetch_secondplace_status()
    render(conn, "index.html",
    firstplace_team: res[:name], firstplace_km: res[:km_value],
    secondplace_team: sec[:name], secondplace_km: sec[:km_value])
  end
end
