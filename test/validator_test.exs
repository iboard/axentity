defmodule ValidatorTest do
  @moduledoc false
  use ExUnit.Case

  alias Altex.Entity

  setup _ do
    {:ok, pid} = TestRepo.start_link()

    on_exit(fn ->
      if Process.alive?(pid), do: Process.exit(pid, :normal)
    end)

    :ok
  end

  describe "validate_presence" do
    test "nil" do
      bob = Entity.init(%TestEntity{name: nil, age: 52})
      assert bob.errors == [name: :cant_be_empty]
    end

    test "empty string" do
      bob = Entity.init(%TestEntity{name: "", age: 52})
      assert bob.errors == [name: :cant_be_empty]
    end

    test "almost empty string" do
      bob = Entity.init(%TestEntity{name: "   ", age: 52})
      assert bob.errors == [name: :cant_be_empty]
    end
  end

  describe "uniqueness" do
    test "cant use name twice" do
      {:ok, bob1} =
        Entity.init(%TestEntity{name: "Bob", age: 52})
        |> TestRepo.store()

      assert TestRepo.list(TestEntity) != []
      assert bob1.errors == []

      {:ok, bob2} =
        Entity.init(%TestEntity{name: "Bob", age: 52})
        |> TestRepo.store()

      assert bob2.errors == [name: :already_exist]
    end
  end
end
