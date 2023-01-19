defmodule Madliaison.NodeinfoWellknown do
  import Plug.Conn

  @schema "http://nodeinfo.diaspora.software/ns/schema/2.0"

  def init(options), do: options

  def call(conn, _opts) do
    body = make_json(Application.get_env(:madliaison, :host))

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end

  def make_json(host) do
    %{
      links: [
        %{
          rel: @schema,
          href: "https://#{host}/nodeinfo/2.0",
        },
      ],
    } |> Jason.encode!
  end
end
