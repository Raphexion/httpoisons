defmodule Httpoisons.WorkerSup do
  use Supervisor
  alias Httpoisons.Worker

  require Logger

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def launch_worker(callback_pid, ref, url, headers, options) do
    Logger.debug("launch worker for #{url}")
    Supervisor.start_child(__MODULE__, [callback_pid, ref, url, headers, options])
  end

  @impl true
  def init(nil) do
    children = [
      %{type: :worker, restart: :transient, id: Worker, start: {Worker, :start_link, []}}
    ]

    opts = [strategy: :simple_one_for_one]
    Supervisor.init(children, opts)
  end
end
