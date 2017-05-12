defmodule HivMonitor.PageController do
  use HivMonitor.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
