defmodule Stronghold.Barracks do
  @moduledoc false

  defstruct [mage: nil, horsemen: nil, stalkers: nil]

  #alias Stronghold.Barracks
  alias Barracks.Troops
  alias Tow.Player



  def train_troops(player, troops, amount) do

      range = 1..amount
      list = Enum.to_list(range)
      id = troop_id(troops)
      troop = Troops.get_troop(id)
      troop = Map.from_struct(troop)

      kirk = []
      jess = Enum.map(list, fn x -> Enum.into(kirk, troop) end)

      %{player | troops: jess}

   end




  defp troop_id(troops) do
    %{
      mage: 1,
      horsemen: 2,
      stalkers: 3
    }[troops]
  end

  end


