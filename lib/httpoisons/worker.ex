defmodule Httpoisons.Worker do
  use GenServer
  require Logger

  def start_link(callback_pid, ref, url, headers, options) do
    GenServer.start_link(__MODULE__, {callback_pid, ref, url, headers, options})
  end

  @impl true
  def init({callback_pid, ref, url, headers, options}) do
    Logger.debug("worker for #{url}")
    {:ok, {callback_pid, ref, url, headers, options}, 0}
  end

  @impl true
  def handle_info(:timeout, state = {callback_pid, ref, url, headers, options}) do
    response = HTTPoison.get(url, headers, options)
    send(callback_pid, {ref, response})
    {:stop, :normal, state}
  end

  @impl true
  def terminate(:normal, _state) do
    Logger.debug("worker done")
    :ok
  end

  def terminate(reason, _state) do
    Logger.debug("terminate with reason #{reason}")
  end
end
