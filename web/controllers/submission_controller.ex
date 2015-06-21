defmodule HelloPhoenix.SubmissionController do
  use HelloPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    IO.puts inspect params
    render conn, "index.html"
  end
end
