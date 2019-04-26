defmodule Httpoisons.Example.Server do
  use GenServer

  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get(url) do
    GenServer.call(__MODULE__, {:get, url})
  end

  @impl true
  def init(nil) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:get, url}, from, refs) do
    ref = Httpoisons.get(url)
    {:noreply, Map.put(refs, ref, from)}
  end

  @impl true
  def handle_info({ref, response}, refs) do
    case Map.get(refs, ref, :missing_ref) do
      :missing_ref ->
        Logger.warn("response with missing ref")

      from ->
        Logger.debug("reply to caller")
        GenServer.reply(from, response)
    end

    {:noreply, Map.delete(refs, ref)}
  end
end
