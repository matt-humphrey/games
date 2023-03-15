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

  describe "Games.ScoreTracker" do
    test "start genserver" do
      {:ok, pid} = Games.ScoreTracker.start_link([])
      assert Process.alive?(pid) == true
    end

    test "add to empty score" do
      {:ok, pid} = Games.ScoreTracker.start_link([])
      Games.ScoreTracker.add(pid, 20)
      assert :sys.get_state(pid) == 20
    end

    test "add to existing score" do
      {:ok, pid} = Games.ScoreTracker.start_link([])
      Games.ScoreTracker.add(pid, 10)
      Games.ScoreTracker.add(pid, 10)
      Games.ScoreTracker.add(pid, 15)
      assert :sys.get_state(pid) == 35
    end

    test "get empty score" do
      {:ok, pid} = Games.ScoreTracker.start_link([])
      assert Games.ScoreTracker.get(pid) == 0
    end

    test "get existing score" do
      {:ok, pid} = Games.ScoreTracker.start_link([])
      Games.ScoreTracker.add(pid, 15)
      assert Games.ScoreTracker.get(pid) == 15
    end
  end
end
