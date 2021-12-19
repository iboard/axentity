defimpl Altex.Persistable, for: Any do
  @spec init(any) :: Altex.Entity.t()
  def init(data), do: data

  @spec get(any, any) :: any
  def get(data, _key), do: data

  @spec validate(any, Altex.Entity.t()) :: Altex.Entity.t()
  def validate(_data, entity), do: entity
end

defimpl Altex.Persistable, for: Map do
  @spec init(any) :: Altex.Entity.t()
  def init(data), do: data

  @spec get(map, any) :: any
  def get(map, key), do: Map.get(map, key)

  @spec validate(any, Altex.Entity.t()) :: Altex.Entity.t()
  def validate(_data, entity), do: entity
end

defimpl Altex.Persistable, for: Keyword do
  @spec init(any) :: Altex.Entity.t()
  def init(data), do: data

  @spec get(any, any) :: any
  def get(data, key), do: Keyword.get(data, key)

  @spec validate(any, Altex.Entity.t()) :: Altex.Entity.t()
  def validate(_data, entity), do: entity
end
