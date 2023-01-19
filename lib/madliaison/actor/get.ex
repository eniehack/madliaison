defmodule Madliaison.Actor.Get do
  import Plug.Conn

   @pubkey Application.compile_env(:madliaison, :public_key)
                    |> File.read!
   @host Application.compile_env(:madliaison, :host)

  def init(opt), do: opt

  def call(conn, _opt) do

    body = payload(@host, @pubkey)

    conn
    |> put_resp_content_type("applciation/activity+json")
    |> send_resp(200, body)
  end

  defp payload(host, pubkey) do
    %{
      "@context" => [
        "https://www.w3.org/ns/activitystreams",
        "https://w3id.org/security/v1",
      ],
      id: "https://#{host}/actor",
      type: "Group",
      preferredUsername: "relay",
      inbox: "https://#{host}/inbox",
      outbox: "https://#{host}/outbox",
      followers: "https://#{host}/actor/followers",
      following: "https://#{host}/actor/following",
      publicKey: %{
        id: "https://#{host}/actor#main-key",
        owner: "https://#{host}/actor",
        publicKeypem: pubkey,
      }
    } |> Jason.encode!
  end
end
