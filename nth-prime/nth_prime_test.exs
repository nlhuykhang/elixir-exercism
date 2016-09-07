if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("nth_prime.exs", __DIR__)
end

ExUnit.start
# ExUnit.configure exclude: :pending, trace: true

defmodule NthPrimeTest do
  use ExUnit.Case

  # @tag :pending
  test "first prime" do
    assert Prime.nth(1) == 2
  end

  @tag :pending
  test "second prime" do
    assert Prime.nth(2) == 3
  end

  @tag :pending
  test "sixth prime" do
    assert Prime.nth(6) == 13
  end

  @tag :pending
  test "fifth prime" do
    assert Prime.nth(5) == 11
  end

  @tag :pending
  test "seventh prime" do
    assert Prime.nth(7) == 17
  end

  @tag :pending
  test "8th prime" do
    assert Prime.nth(8) == 19
  end

  @tag :pending
  test "9th prime" do
    assert Prime.nth(9) == 23
  end

  @tag :pending
  test "100th prime" do
    assert Prime.nth(100) == 541
  end

  @tag :pending
  test "weird case" do
    catch_error Prime.nth(0)
  end
end
