defmodule Games.Application do
  use Application

  @impl true
  def start(_type, _args_) do
    IO.puts("Starting Games.Application")
    children = []
    opts = [strategy: :one_for_one, name: Games.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
