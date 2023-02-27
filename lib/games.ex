defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """
end

defmodule Games.GuessingGame do
  @doc """
  A guessing game, where the user guesses a number between 1 and 10.

  ## Examples

      iex> Games.GuessingGame.play()

  """
  def play() do
    play(Enum.random(1..10))
  end

  def play(number) do
    guess = IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
    |> _check(number)
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
