defmodule Tow.MapFile do
  @moduledoc false

  @doc """
  Reads a CSV file of Tiles and thier respective Spec values.

  Returns a list of maps with each map containing the following keys:

    * `:name` - the tile (name)
    * `tag` - the tag value
  """
  def read_mapfile do
    "../../data/mapfile.json"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> Poison.Parser.parse!(%{})
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [name, tag] ->
      %{name: name, tag: String.to_integer(tag)}
    end)
  end
end



