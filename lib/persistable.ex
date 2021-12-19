defprotocol Altex.Persistable do
  @moduledoc ~s"""
  A protocol for all data types handled in `Altex.Entity` and `Altex.Repo`
  """

  alias Altex.Entity

  @fallback_to_any true

  @spec init(any) :: Entity.t()
  @doc """
  Setup, sanitize, or normalize args or return them unchanged
  """
  def init(args)

  @doc """
  Check all fields of the entity and add `errors` to `entity.errors` if there are any.
  The entity must implement the `validate/2` function from the `Persistable` protocol.
  """
  @spec validate(any, Entity.t()) :: Entity.t()
  def validate(data, entity)

  @doc """
  Get the value of `key` from `data` assuming there is an implementation of the
  get-function of the `Persistable` protocol.
  """
  @spec get(any, atom | String.t()) :: any
  def get(data, key)
end
