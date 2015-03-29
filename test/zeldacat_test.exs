defmodule ZeldacatTest do
  use ExUnit.Case

  test "has health of 100 and is alive when initialized" do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, HealthComponent, 100)
    assert HealthComponent.get_hp(entity) == 100
    assert HealthComponent.alive?(entity) == true
  end

  test "it can lose health" do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, HealthComponent, 100)
    Entity.notify(entity, {:hit, 50})
    assert HealthComponent.get_hp(entity) == 50
  end

  test "it can gain health" do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, HealthComponent, 100)
    Entity.notify(entity, {:hit, 50})
    Entity.notify(entity, {:heal, 25})
    assert HealthComponent.get_hp(entity) == 75
  end

  test "it knows it's dead at 0 health" do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, HealthComponent, 100)
    assert HealthComponent.alive?(entity) == true
    Entity.notify(entity, {:hit, 100})
    assert HealthComponent.get_hp(entity) == 0
    assert HealthComponent.alive?(entity) == false
  end

  test "something with an XYComponent can move around" do
    {:ok, entity} = Entity.init()
    Entity.add_component(entity, XYComponent, {50, 50})
    Entity.notify(entity, {:move, {:y, 35}})
    assert XYComponent.get_position(entity) == {50, 35}
  end
end
