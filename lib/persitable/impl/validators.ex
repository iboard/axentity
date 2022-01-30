defmodule Altex.Persistable.Validators do
  @moduledoc false

  alias Altex.Entity

  @spec validate_greater_or_equal_than(Entity.t(), Keyword.t()) :: Entity.t()
  def validate_greater_or_equal_than(entity, max_values) do
    errors =
      Enum.reduce(max_values, entity.errors, fn {field, max_value}, errs ->
        if Entity.get(entity, field) < max_value,
          do: Keyword.put(errs, field, {:cant_be_less_than, max_value}),
          else: errs
      end)

    %{entity | errors: errors}
  end

  @spec validate_presence(Entity.t(), list(atom)) :: Entity.t()
  def validate_presence(entity, keys) do
    errors =
      Enum.reduce(keys, entity.errors, fn key, errs ->
        value = Entity.get(entity, key)

        if empty?(value),
          do: Keyword.put(errs, key, :cant_be_empty),
          else: errs
      end)

    %{entity | errors: errors}
  end

  @spec validate_unique(Entity.t(), list(atom), atom) :: Entity.t()
  def validate_unique(entity, keys, repo) do
    errors =
      Enum.reduce(keys, entity.errors, fn key, errs ->
        exists = apply(repo, :find_by, [entity, key])
        if exists,
           do: Keyword.put(errs, key, :already_exist),
           else: errs
      end)

    %{entity | errors: errors}
  end

  defp empty?(nil), do: true
  defp empty?(""), do: true
  defp empty?([]), do: true

  defp empty?(str) when is_binary(str) do
    String.trim(str) == ""
  end

  defp empty?(_), do: false
end
