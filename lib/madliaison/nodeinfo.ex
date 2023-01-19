defmodule Madliaison.Nodeinfo do
  import Plug.Conn

  @name "madliaison"
  @version "0.1.0"

  def init(options), do: options

  def call(conn, _opts) do
    body = make_json([])

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  def make_json(peers) do
    %{
      openRegistrations: true,
      protocols: ["activitypub"],
      services: %{
        inbound: [],
        outbound: [],
      },
      software: %{
        name: @name,
        version: @version,
      },
      usage: %{
        localPosts: 0,
        users: %{
          total: 1
        }
      },
      version: "2.0",
      metadata: %{
        peers: peers,
      }
    }
    |> Jason.encode!
  end
end
