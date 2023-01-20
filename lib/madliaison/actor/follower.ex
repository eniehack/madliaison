defmodule Madliaison.Actor.Followers do
  import Plug.Conn

  @host Application.compile_env(:madliaison, :host)

  def init(opt), do: opt

  def call(conn, opt) do
    if fetch_query_params(conn, :page) === "" do
      body = build_payload_with_page_link(@host)
      conn
      |> put_resp_content_type("application/activity+json")
      |> send_resp(200, body)
    else
      body = build_payload(@host)

      conn
      |> put_resp_content_type("application/activity+json")
      |> send_resp(200, body)
    end
  end

  def build_payload_with_page_link(host) do
    %{
      "@context" => "https://www.w3.org/ns/activitystreams",
      id: "#{host}/actor/followers",
      type: "OrderedCollectionPage",
      totalItems: 0.
      first: "#{host}/actor/followers?page=1",
    }
    |> Jason.encode!
  end

  def build_payload(host) do
    %{
      "@context" => "https://www.w3.org/ns/activitystreams",
      id: "#{host}/actor/followers",
      type: "OrderedCollectionPage",
      totalItems: 0.
      partOf: "#{host}/actor/followers"
      orderedIterms: [],
    }
    |> Jason.encode!
  end
end
