defmodule Github.InMemory do
  use Github, "work.com"

  def user_emails("gh_user"), do: ["slack_user@work.com"]
  def user_emails("gh_user2"), do: ["slack_user2@work.com"]
end
