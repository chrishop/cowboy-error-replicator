defmodule CowboyErrorReplicator.Endpoint do
   @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)



  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  get "/timeout" do
    Process.sleep(5_000)
    send_resp(conn, 200, "I should timeout")
  end

  get "/replicate" do
    send_resp(conn, 200, "replicated route reached")
    send_resp(conn, 200, "replicated route reached (2nd)")
  end

  get "/with-sleep" do
    send_resp(conn, 200, "replicated route reached")
    Process.sleep(3_000)
    send_resp(conn, 200, "replicated route reached (2nd)")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

end
