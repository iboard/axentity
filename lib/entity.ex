defmodule Altex.Entity do
  @moduledoc """
  An `Entity` is a wrapper around any `data` that implements the
  `Persistable` protocol.
  It's aim is to handle and track changes. (Yes, think about
  Ecto.Changeset but different)

  An `Entity-implementatoin` must implement the `Persistable` protocol,
  thus `Entity` can call `init`, `get`, and `validate`.
  """

  alias __MODULE__
  alias Altex.Persistable

  require UUID
  defstruct data: nil, uuid: nil, errors: []

  @type t() :: %Entity{}
  @spec init(any) :: Entity.t()
  @doc """
  ### Examples:

      iex> entity = Entity.init(1)
      ...> %Entity{data: 1, uuid: _uuid} = entity

      iex> entity = Entity.init(1.4)
      ...> %Entity{data: 1.4, uuid: _uuid} = entity

      iex> entity = Entity.init(:something)
      ...> %Entity{data: :something, uuid: _uuid } = entity

      iex> entity = Entity.init(~w/hello world/)
      ...> %Entity{data: ["hello", "world"], uuid: _uuid } = entity

      iex> entity = Entity.init({:foo, :bar})
      ...> %Entity{data: {:foo, :bar}, uuid: _uuid } = entity
  """
  def init(data, uuid \\ nil) do
    %Entity{uuid: uuid || UUID.uuid4(), data: Persistable.init(data)}
    |> validate()
  end

  @spec validate(t) :: t
  @doc ~s"""
  Check entity and set `errors: []` if any.
  """
  def validate(entity) do
    Persistable.validate(entity.data, entity)
  end

  @spec get(t, any) :: any
  @doc ~s"""
  Get the value of `key` from `data` of the entity when the entity implements the
  get-function of the `Persistable` protocol.

  ### Example

      iex> e = Entity.init(%{foo: :bar})
      ...> Entity.get(e, :foo)
      :bar

      iex> e = Entity.init(%{ 1 => :foo, 2 => :bar})
      ...> Entity.get(e, 2)
      :bar

  """
  def get(entity, key) do
    Persistable.get(entity.data, key)
  end
end
