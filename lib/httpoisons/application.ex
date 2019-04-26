defmodule Httpoisons.Application do
  @moduledoc false

  use Application
  alias Httpoisons.WorkerSup

  def start(_type, _args) do
    children = [
      %{type: :supervisor, id: WorkerSup, start: {WorkerSup, :start_link, []}}
    ]

    opts = [strategy: :one_for_one, name: Httpoisons.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
