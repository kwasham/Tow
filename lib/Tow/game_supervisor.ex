defmodule Tow.GameSupervisor do
  @moduledoc """
  A supervisor that starts `GameServer` processes dynamically.
  """

  use DynamicSupervisor

  alias Tow.GameServer

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Starts a `GameServer` process and supervises it.
  """
  def start_game(realm_name, size) do
    child_spec = %{
      id: GameServer,
      start: {GameServer, :start_link, [realm_name, size]},
      restart: :permanent
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  @doc """
  Terminates the `GameServer` process normally. It won't be restarted.
  """
  def stop_game(realm_name) do
    :ets.delete(:realms_table, realm_name)

    child_pid = GameServer.game_pid(realm_name)
    DynamicSupervisor.terminate_child(__MODULE__, child_pid)
  end
end
