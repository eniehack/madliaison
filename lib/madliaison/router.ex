defmodule Madliaison.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Welcome")
  end

  get "/.well-known/webfinger", to: Madliaison.Webfinger
  get "/.well-known/nodeinfo", to: Madliaison.NodeinfoWellknown
  get "/nodeinfo/2.0", to: Madliaison.Nodeinfo
  get "/actor", to: Madliaison.Actor.Get

  match _ do
    send_resp(conn, 404, "Oops!")
  end

end
