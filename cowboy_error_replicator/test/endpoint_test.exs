defmodule CowboyErrorReplicator.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts CowboyErrorReplicator.Endpoint.init([])

  test "it returns pong from /ping" do
    conn = conn(:get, "/ping")

    conn = CowboyErrorReplicator.Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong!"
  end
end
