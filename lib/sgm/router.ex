defmodule SGM.Router do
  use Plug.Router
  require Logger
  alias Github.Mention
  alias SGM.Bridge

  @domain Application.get_env(:sgm, :domain)
  @slack_client Application.get_env(:sgm, :slack_client).module
  @github_client Application.get_env(:sgm, :github_client).module

  plug :match
  plug :dispatch

  post "/on-mention" do
    {:ok, request_body, _conn} = Plug.Conn.read_body(conn)
    log_headers(conn)
    request_body
    |> Mention.from_github_json
    |> Bridge.mention_to_messages(@github_client, @domain)
    |> Enum.each(&@slack_client.send_message/1)

    send_resp(conn, 200, "OK")
  end

  defp log_headers(conn) do
    formatted_headers =
      conn.req_headers
      |> Enum.filter(fn {k, v} -> k =~ ~r/.*hub.*/ end)
      |> inspect

    Logger.debug "Github: received headers:\n#{formatted_headers}"
  end
end
