defmodule SlackGithubMention do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
    ]

    opts = [strategy: :one_for_one, name: SlackGithubMention.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    { :ok, _ } = Plug.Adapters.Cowboy.http SlackGithubMention.Router, []
  end
end
