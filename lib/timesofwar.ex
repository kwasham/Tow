defmodule TimesOfWar do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Tow.GameRegistry},
      Tow.TileCache,
      Tow.GameSupervisor
    ]

    :ets.new(:realms_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: Tow.Supervisor]
    Supervisor.start_link(children, opts)


    end

  def hello do
    :world

  end
end

