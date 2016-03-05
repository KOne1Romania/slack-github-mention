use Mix.Config

data = %{
  commit: %{
    headline: "You were mentioned on a commit:",
    thumb_url: "https://cdn0.iconfinder.com/data/icons/octicons/1024/git-commit-512.png"
  }
}

config :sgm,
  port: 4000,
  data: data

import_config "#{Mix.env}.exs"
