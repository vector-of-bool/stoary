defmodule Stoary.HTTP do
  use Plug.Router

  plug Plug.Logger
  use Plug.Debugger

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_header("Location", "/app")
    |> send_resp(301, "Moved")
  end

  get "/app" do
    send_resp(conn, 200, "Hello, app!")
  end

  match _ do
    send_resp(conn, 404, "404 - Nothing here")
  end
end