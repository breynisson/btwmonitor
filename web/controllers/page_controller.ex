defmodule HivMonitor.PageController do
  use HivMonitor.Web, :controller

  alias Fetch.Results

  def index(conn, _params) do
    res = Results.fetch_firstplace_status()
    render(conn, "index.html",firstplace_team: res[:name], firstplace_km: res[:km_value])
  end
end
