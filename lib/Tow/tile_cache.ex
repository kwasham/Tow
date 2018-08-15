defmodule Tow.TileCache do
  @moduledoc """
  A process that loads a collection of Tiles from an external source
  and caches them for expedient access. The cache is automatically
  refreshed every hour.
  """

  use GenServer

  @refresh_interval :timer.minutes(60)

  # Client (Public) Interface

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_tiles() do
    GenServer.call(__MODULE__, :get_tiles)
  end

  # Server Callbacks

  def init(:ok) do
    state = load_tiles()
    schedule_refresh()
    {:ok, state}
  end

  def handle_call(:get_tiles, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:refresh, _state) do
    state = load_tiles()
    schedule_refresh()
    {:noreply, state}
  end

  defp schedule_refresh do
    Process.send_after(self(), :refresh, @refresh_interval)
  end

  # Loads tiles from a CSV file, though you could load
  # them from any source, such as an external API.
  defp load_tiles() do
    #Tow.MapFile.read_mapfile()
  end
end
