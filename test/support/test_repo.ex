defmodule TestRepo do
  @moduledoc false

  alias Altex.Entity

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_), do: {:ok, %{}}

  def store(entity) do
    e = GenServer.call(__MODULE__, {:store, entity})
    {:ok, e}
  end

  def load(type, uuid) do
    if e = GenServer.call(__MODULE__, {:load, type, uuid}) do
      {:ok, Entity.force_init(e, uuid)}
    else
      {:error, :not_found}
    end
  end

  def list(type) do
    GenServer.call(__MODULE__, {:list, type})
    |> Enum.map(fn {{_type, uuid}, entity} ->
      Entity.force_init(entity, uuid)
    end)
  end

  def find_by(example, field) do
    %type{} = example.data

    list(type)
    |> Enum.find(fn e -> Entity.get(e, field) == Entity.get(example, field) end)
  end

  def handle_call({:store, entity}, _, store) do
    data = entity.data
    map_key = get_key(entity)

    {:reply, entity, Map.put(store, map_key, data)}
  end

  def handle_call({:load, type, uuid}, _, store) do
    map_key = get_key(type, uuid)
    {:reply, Map.get(store, map_key), store}
  end

  def handle_call({:list, type}, _, store) do
    keys =
      Map.keys(store)
      |> Enum.filter(fn k ->
        {t, _id} = k
        t == type
      end)

    {:reply, Map.take(store, keys), store}
  end

  defp get_key(type, id), do: {type, id}

  defp get_key(entity) do
    %type{} = entity.data
    {type, entity.uuid}
  end
end
