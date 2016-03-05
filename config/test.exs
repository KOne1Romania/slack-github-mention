use Mix.Config

domain = "test_company.com"

config :sgm,
  domain: domain,
  slack_client: %{
    module: Slack.InMemory,
  },
  github_client: %{
    module: Github.InMemory,
    emails: %{
      "gh_user" => ["slack_user@#{domain}"],
      "gh_user2" => ["slack_user2@#{domain}"]
    }
  }

# config: :sgm,
#   domain: "your_company.com"
#   slack_client: %{
#     module: Slack.HTTPClient,
#     url: "http://your-slack-hook-url"
#   },
#   github_client: %{
#     module: Github.HTTPClient,
#     url: "http://your-github-api-url"
#   }
