defmodule Slack do
  @doc """
  Sends mention notification
  """
  @callback send_message(Slack.Message.t) :: nil
end
