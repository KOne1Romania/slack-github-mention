defmodule SlackGithubMention.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "it works")
  end

  post "/on-mention" do
    # conn.body_params
    # |> Comment.from_github_event
    # |> Notifier.notify_mentioned_users

    send_resp(conn, 200, "")
  end
end
