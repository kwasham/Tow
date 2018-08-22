defmodule Stronghold.Barracks do
  @moduledoc false

  defstruct [mage: nil, horsemen: nil, stalkers: nil]

  #alias Stronghold.Barracks
  alias Barracks.Troops
  alias Tow.Player



  def train_troops(player, troops, amount) do



     sadie = Map.update(player.troops, troops, amount, &(&1 + amount))

     #troop = Enum.map(kirk, fn {k, v} -> {k, (v + amount)} end)


     #jess = Map.put(troop, troops, amount)


      %{player | troops: sadie}

   end




  defp troop_id(troops) do
    %{
      mage: 1,
      horsemen: 2,
      stalkers: 3
    }[troops]
  end

  end


