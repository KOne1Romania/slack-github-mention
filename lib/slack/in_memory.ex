defmodule SGM.Slack.InMemory do
  @behaviour SGM.Slack

  @mapping %{
    "zaboco" => "bogdan.zaharia"
  }

  def username_for_github_name(gh_uname) do
    @mapping[gh_uname]
  end
end
