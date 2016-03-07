defmodule Slack.HTTPClient do
  @behaviour Slack
  require Logger

  @slack_url Application.get_env(:sgm, :slack_client).url

  def send_message(message) do
    send_with_log Poison.encode!(message), fn json ->
      HTTPoison.post!(@slack_url, json)
    end
  end

  defp send_with_log(message_json, send_fn) do
    Logger.info "Slack: sending message:\n#{message_json}"
    formatted_resp =
      send_fn.(message_json)
      |> Map.take([:body, :status_code])
      |> inspect

    Logger.info "Slack: Got response: #{formatted_resp}"
  end
end
