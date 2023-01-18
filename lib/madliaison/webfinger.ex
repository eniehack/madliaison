defmodule Madliaison.Webfinger do
  import Plug.Conn

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
          rel: "self",
          type: "application/activity+json",
          href: "https://#{host}/actor",
        }
      ],
      subject: "acct:relay@#{host}",
    }
    |> Jason.encode!
  end
end
