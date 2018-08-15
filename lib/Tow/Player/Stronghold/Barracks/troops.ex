defmodule Barracks.Troops do
  @moduledoc false

  alias Barracks.Troops
  #alias Stronghold.Barracks

  defstruct [amount: nil, id: nil, name: "", type: "", tier: nil, strengths: "", weakness: "", stats: %{attack: nil, defense: nil, health: nil, speed: nil, upkeep: nil, power: nil, load: nil}]

  def list_troops do
    [
      %Troops{id: 1, name: "Mage", type: "Infantry", tier: 1, strengths: "Cavalry", weakness: ["Ranged", "Traps"], stats: %{attack: 2, defense: 1, health: 4, speed: 8, upkeep: 2, power: 3, load: 4}},
      %Troops{id: 2, name: "Horsemen", type: "Cavalry", tier: 1, strengths: "Ranged", weakness:  ["Infantry", "Siege"], stats: %{attack: 3, defense: 1, health: 6, speed: 8, upkeep: 2, power: 4, load: 4}},
      %Troops{id: 3, name: "Stalker", type: "Ranged", tier: 1, strengths: "Inf", weakness:  ["Cavalry", "Siege"], stats: %{attack: 1, defense: 1, health: 2, speed: 8, upkeep: 2, power: 2, load: 6}}
    ]
  end

  def get_troop(id) when is_integer(id) do
    Enum.find(list_troops(), fn (t) -> t.id == id end)
  end

  def get_troop(id) when is_binary(id) do
    id |> String.to_integer |> get_troop
  end

end




