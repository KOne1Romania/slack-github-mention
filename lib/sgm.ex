defmodule SGM do
  use Application
  require Logger

  @port Application.get_env(:sgm, :port)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
    ]

    opts = [strategy: :one_for_one, name: SGM.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    Logger.info "Listening on port #{@port}"
    { :ok, _ } = Plug.Adapters.Cowboy.http SGM.Router, port: @port
  end
end
