defmodule Httpoisons do
  @moduledoc """
  Documentation for Httpoisons.
  """
  def get(url, headers \\ [], options \\ []) do
    callback_pid = self()
    ref = make_ref()
    {:ok, _worker} = Httpoisons.WorkerSup.launch_worker(callback_pid, ref, url, headers, options)
    ref
  end
end
