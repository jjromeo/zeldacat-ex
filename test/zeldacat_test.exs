defmodule ZeldacatTest do
  use ExUnit.Case

  setup do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, HealthComponent, 100)
  end

  test "has health of 100 and is alive when initialized" do
    assert HealthComponent.get_hp(entity) == 100
    assert HealthComponent.alive?(entity) == true
  end

  test "it can lose health" do
    Entity.add_component(entity, HealthComponent, 100)
    Entity.notify(entity, {:hit, 50})
    assert HealthComponent.get_hp(entity) == 50
  end

  test "it can be healed" do
    Entity.notify(entity, {:hit, 50})
    Entity.notify(entity, {:heal, 25})
    assert HealthComponent.get_hp(entity) == 75
  end

  test "it knows when it's dead" do
    Entity.notify(entity, {:hit, 100})
    assert HealthComponent.get_hp(entity) == 0
    assert HealthComponent.alive?(entity) == false
  end

end
