defmodule GamesTest do
  use ExUnit.Case
  doctest Games

  @tag :benchmark
  test "benchmark wordle feedback" do
    Benchee.run(%{
      "Incorrect" => fn -> Games.Wordle.feedback("apple", "grape") end,
      "Correct" => fn -> Games.Wordle.feedback("apple", "apple") end
    })
  end
end
