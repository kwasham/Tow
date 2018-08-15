defmodule Tow.Tile do
  @moduledoc false

  @enforce_keys [:name, :tag]
  defstruct [:name, :marked_by, :tag]

  alias  __MODULE__


  @doc """
  Creates a tile from the given `name` and `tag`.
  """
  def new(name, tag) do
    %Tile{name: name, tag: tag}
  end

  @doc """
  Creates a square from the given map with `:phrase` and `:points` keys.
  """
  def from_tile_sets(%{name: name, tag: tag}) do
    Tile.new(name, tag)
  end



end
