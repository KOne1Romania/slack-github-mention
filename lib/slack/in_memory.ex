defmodule Slack.InMemory do
  @behaviour Slack
  require Logger

  def send_message(message) do
    formatted_message = Poison.encode!(message, pretty: true)
    Logger.debug "Sending slack message:\n#{formatted_message}"
  end
end
