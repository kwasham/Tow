defmodule Tow.BattleMap do
  @moduledoc false

  alias Tow.{BattleMap, Tile, MapFile}


  defstruct [coords: %{}, tiles: nil, height: nil, width: nil, layers: nil]

  @doc """
  Creates a game with a `size` x `size` collection of squares
  taken randomly from the given list of `buzzwords` where
  each buzzword is of the form `%{phrase: "Upsell", points: 10}`.
  """
  def new do
    mapfiles = MapFile.read_mapfile()
    BattleMap.new(mapfiles)
  end

  @doc """
  Creates a game with a `size` x `size` collection of squares
  taken randomly from the given list of `buzzwords` where
  each buzzword is of the form `%{phrase: "Upsell", points: 10}`.
  """
  def new(mapfiles) do
#    tiles =
#      mapfiles
#      |> Enum.shuffle()
#      |> Enum.take(3)
#      |> Enum.map(&Tile.from_tile_sets(&1))
#      |> Enum.chunk_every(3)
#
#    %BattleMap{tileheight: tiles}
  end

  @doc """
  Marks the tile that has the given `name` for the given `Player`, and updates the coords.
  """
  def mark(battle_map, tile_name, player) do
    battle_map
    |> update_tiles_with_mark(tile_name, player)
    |> update_coords()
  end

  defp update_tiles_with_mark(battle_map, tile_name, player) do
    new_tiles =
      battle_map.tileheight
      |> List.flatten()
      |> Enum.map(&mark_tile_having_name(&1, tile_name, player))
      |> Enum.chunk_every(Enum.count(battle_map.tiles))

    %{battle_map | tileheight: new_tiles}
  end

  defp mark_tile_having_name(tile, tile_name, player) do
    case tile.name == tile_name do
      true -> %Tile{tile | marked_by: player}
      false -> tile
    end
  end

  defp update_coords(battle_map) do
    coords =
      battle_map.tileheight
      |> List.flatten()
      |> Enum.reject(&is_nil(&1.marked_by))
      |> Enum.map(fn s -> {s.marked_by.name, s.tag} end)
      |> Enum.reduce(%{}, fn {name, tag}, coords ->
        Map.update(coords, name, tag, &(&1 + tag)) end)

      %{battle_map | coords: coords}
  end

end
