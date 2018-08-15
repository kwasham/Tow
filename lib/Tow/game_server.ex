defmodule Tow.GameServer do
  @moduledoc """
  A game server process that holds a `Realm` struct as its state.
  """

  use GenServer

  require Logger

  # Client (Public) Interface

  @doc """
  Spawns a new game server process registered under the given `realm_name`
  """
  def start_link(realm_name) do
    GenServer.start_link(__MODULE__,
                        {realm_name},
                        name: via_tuple(realm_name))
  end

  def summary(realm_name) do
    GenServer.call(via_tuple(realm_name), :summary)
  end

  def mark(realm_name, tile_name, player) do
    GenServer.call(via_tuple(realm_name), {:mark, tile_name, player})
  end

  @doc """
  Returns a tuple used to regester and lookup a game server process by name.
  """
  def via_tuple(realm_name) do
    {:via, Registry, {Tow.GameRegistry, realm_name}}
  end

  @doc """
  Returns the `pid` of the game server process registered under the given `realm_name`, or `nil` if no process registered
  """
  def game_pid(realm_name) do
    realm_name
    |> via_tuple()
    |> GenServer.whereis()
  end

  # Server Callbacks

  def init({realm_name}) do
    tiles = Tow.TileCache.get_tiles()

    battle_map =
      case :ets.lookup(:realms_table, realm_name) do
        [] ->
          battle_map = Tow.BattleMap.new(tiles)
          :ets.insert(:realms_table, {realm_name, battle_map})
          battle_map

          [{^realm_name, battle_map}] ->
            battle_map
      end

      Logger.info("Spawned game server Process named `#{realm_name}`.")

      {:ok, battle_map}
  end

  def handle_call(:summary, _from, battle_map) do
    {:reply, summarize(battle_map), battle_map}
  end

  def handle_call({:mark, tile_name, player}, _from, battle_map) do
    new_battle_map = Tow.BattleMap.mark(battle_map, tile_name, player)

    :ets.insert(:realms_table, {my_realm_name(), new_battle_map})

    {:reply, summarize(new_battle_map), new_battle_map}
  end

  def summarize(battle_map) do
    %{
      tiles: battle_map.tileheight,
      #size: battle_map.size,
      coords: battle_map.coords
    }
  end

  def handle_info(battle_map) do
    {:stop, {:shutdown}, battle_map}
  end

  def terminate({:shutdown}, _battle_map) do
    :ets.delete(:realms_table, my_realm_name())
    :ok
  end

  def terminate(_reason, _battle_map) do
    :ok
  end

  defp my_realm_name do
    Registry.keys(Tow.GameRegistry, self()) |> List.first
  end
end

