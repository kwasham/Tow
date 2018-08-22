defmodule TimesOfWarTest do
  use ExUnit.Case, async: true
  doctest TimesOfWar

  test "greets the world" do
    assert TimesOfWar.hello() == :world

  end

  test "stores values by keys" do
    bucket = start_supervised!(Tow.Bucket)
    assert Tow.Bucket.get(bucket, "milk") == nil

    Tow.Bucket.put(bucket, "milk", 3)
    assert Tow.Bucket.get(bucket, "milk") == 3
  end

end
