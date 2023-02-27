defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """
end

defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Guessing Game`.
  """
  @doc """
  A guessing game, where the user guesses a number between 1 and 10.

  ## Examples

  """
  def play() do
    play(Enum.random(1..10))
  end

  def play(number) do
    guess = IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()

    _check(guess, number)
  end

  defp _check(number, number), do: "Correct!"
  defp _check(guess, number) do
    cond do
      guess > number -> IO.puts "Too High!"
      guess < number -> IO.puts "Too Low!"
    end
    play(number)
  end
end

defmodule Games.RockPaperScissors do
  @moduledoc """
  Documentation for `Scissors Paper Rock`
  """
  @winner %{rock: :scissors, scissors: :paper, paper: :rock}
  def play() do
    computer = Enum.random([:rock, :paper, :scissors])
    player = IO.gets("scissors/paper/rock: ")
    |> String.trim()
    |> String.to_atom()

    cond do
      player == computer -> "It's a tie!"
      @winner[player] == computer -> "You win! #{player} beats #{computer}."
      @winner[computer] == player -> "You lose! #{computer} beats #{player}."
    end
  end
end
