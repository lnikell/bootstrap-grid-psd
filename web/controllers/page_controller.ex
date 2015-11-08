defmodule BootstrapGridPsd.PageController do
  require Logger
  use BootstrapGridPsd.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def generate_grid(conn, params) do
    line_to_insert = "var gridGuides = " <> params["grid_guides"]
    case File.read(Path.relative_to_cwd("web/static/grid.jsx.tmp")) do
      {:ok, body} -> 
        new_body = line_to_insert <> body
      {:error, reason} -> 
        Logger.debug reason
    end
    conn
      |> put_resp_header("content-disposition", "attachment; filename='grid.jsx'")
      |> text new_body
  end
end
