defmodule SGM.Router do
  use Plug.Router
  alias Github.Mention
  alias Slack.Message
  alias SGM.Bridge

  @domain Application.get_env(:sgm, :domain)
  @slack_client Application.get_env(:sgm, :slack_client).module
  @github_client Application.get_env(:sgm, :github_client).module

  plug :match
  plug :dispatch

  post "/on-mention" do
    {:ok, request_body, _conn} = Plug.Conn.read_body(conn)
    messages = request_body
    |> Mention.from_github_json
    |> Bridge.mention_to_messages(@github_client, @domain)
    |> Enum.each(&@slack_client.send_message/1)

    send_resp(conn, 200, "OK")
  end
end
