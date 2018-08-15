defmodule Stronghold.Barracks do
  @moduledoc false

  defstruct [mage: nil, horsemen: nil, stalkers: nil]

  #alias Stronghold.Barracks
  alias Barracks.Troops
  alias Tow.Player



  def train_troops(player, troops, amount) do

      id = troop_id(troops)
      troop = Troops.get_troop(id)
      troop = %{troop | amount: amount}
      #troop = Map.update!(player.troops, troops, &(&1 + amount))


       %{player | troops: troop}


   end




  defp troop_id(troops) do
    %{
      mage: 1,
      horsemen: 2,
      stalkers: 3
    }[troops]
  end

  end


