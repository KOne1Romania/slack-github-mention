defmodule SGM.Slack do
  @doc """
  Maps github username -> slack username
  """
  @callback username_for_github_name(String.t) :: String.t

  @doc """
  Sends mention notification to the given slack url
  """
  @callback send_message(slack_url :: String.t, Slack.Message.t) :: nil
end
