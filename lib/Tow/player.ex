defmodule Tow.Player do
  @moduledoc false

alias Barracks.Troops

  @enforce_keys [:name]
  defstruct [:name, resources: %{}, troops: %{}]

  @doc """
  Creates a Player with the given `name` and `auth_token`. Because we are nice, we give every Player 100 of each resource to start with.
  """
  def new(name) do
    resources = %{stone: 100, wood: 100, food: 100, ore: 100}
    %Tow.Player{ name: name, resources: resources}
  end


end


