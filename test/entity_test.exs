defmodule EntityTest do
  @moduledoc false
  use ExUnit.Case

  alias Altex.Entity

  doctest Entity

  setup _ do
    {:ok, pid} = TestRepo.start_link()

    on_exit(fn ->
      if Process.alive?(pid), do: Process.exit(pid, :normal)
    end)

    :ok
  end

  describe "Basics" do
    test ".init creates an UUID(4)" do
      entity1 = Entity.init(:foo)
      entity2 = Entity.init(:bar)
      assert entity1.uuid |> is_binary
      assert entity2.uuid |> is_binary
      assert entity1.uuid != entity2.uuid
    end
  end

  describe "TestEntity" do
    test ".init(TestEntity) with valid params" do
      %Entity{uuid: uuid} = bob = Entity.init(%TestEntity{name: "Bob", age: 50})
      %Entity{uuid: ^uuid, data: %TestEntity{name: "Bob", age: 50}} = bob
      assert is_binary(uuid)
    end

    test ".init(TestEntity) with invalid params" do
      %Entity{uuid: uuid} = bobby = Entity.init(%TestEntity{})

      %Entity{
        uuid: ^uuid,
        data: %TestEntity{age: 0, name: nil} = _my_raw_entity,
        errors: [
          age: {:cant_be_less_than, 18},
          name: :cant_be_empty
        ]
      } = bobby
    end
  end

  describe "Persistence" do
    test "full integration loop: init, create, load entity, and list repo" do
      repo = TestRepo

      {:ok, frank} =
        %TestEntity{name: "Frank", age: 80}
        |> Entity.init()
        |> repo.store()

      {:ok, bob} =
        %TestEntity{name: "Bob", age: 60}
        |> Entity.init()
        |> repo.store()

      assert {:error, :not_found} == repo.load(TestEntity, "not-existing-id")

      {:ok, ^bob} = repo.load(TestEntity, bob.uuid)
      {:ok, ^frank} = repo.load(TestEntity, frank.uuid)

      list = repo.list(TestEntity)
      assert Enum.member?(list, bob)
      assert Enum.member?(list, frank)
    end
  end
end
