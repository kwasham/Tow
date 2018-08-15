defmodule Tow.Barracks do

  alias Tow.Troops
  alias Tow.Player

  def list_troops do
    [
      %Troops{id: 1, name: "Mage", type: "Infantry", tier: 1, strengths: "Cavalry", weakness:  "Ranged", stats: %{attack: 1, defense: 1, health: 4, speed: 8, upkeep: 2, power: 1, load: 4}},
      %Troops{id: 2, name: "Horseman", type: "Cavalry", tier: 1, strengths: "Ranged", weakness:  "Inf", stats: %{attack: 1, defense: 1, health: 4, speed: 8, upkeep: 2, power: 1, load: 4}},
      %Troops{id: 3, name: "Stalker", type: "Ranged", tier: 1, strengths: "Inf", weakness:  "Cavalry", stats: %{attack: 1, defense: 1, health: 4, speed: 8, upkeep: 2, power: 1, load: 4}}
    ]
  end



  def train_troops(player, troop, amount) do
    troop = Map.update!(player.troops, :amount, &(&1 + amount))



    %{player | troops: troop}
  end

  def create_mage do
    %Troops{id: 1, name: "Mage", type: "Infantry", tier: 1, strengths: "Cavalry", weakness:  "Ranged", stats: %{attack: 1, defense: 1, health: 4, speed: 8, upkeep: 2, power: 1, load: 4}}
  end

  def create_stalker do
    %Troops{id: 3, name: "Stalker", type: "Ranged", tier: 1, strengths: "Inf", weakness:  "Cavalry", stats: %{attack: 1, defense: 1, health: 4, speed: 8, upkeep: 2, power: 1, load: 4}}
  end

end
