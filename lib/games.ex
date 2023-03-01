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

defmodule Games.Wordle do
  @moduledoc """
  Create a replica of Wordle
  """

  @doc """
  Initiate the game.
  """
  def play() do
    word = Enum.random(["hello", "water", "grass", "apple", "grape"])
    do_play(word, 0)
  end

  defp do_play(_, 6), do: "Too many guesses! You lose."

  defp do_play(word, count) do
    guess = IO.gets("Enter a five letter word: ")
    output = feedback(word, guess)

    if Enum.all?(output, fn colour -> colour == :green end) do
      IO.puts "Correct!"
    else
      [l1, l2, l3, l4, l5 | _] = String.split(guess, "", trim: true) # take each letter from the guess
      [c1, c2, c3, c4, c5] = output # determine the colour corresponding to each letter
      IO.puts(IO.ANSI.format([c1, l1, c2, l2, c3, l3, c4, l4, c5, l5], true))
      do_play(word, count + 1)
    end
  end

  @doc """
  Output a list of atoms to indicate which letters in the word, and in the exact position.

  ## Examples

  iex> Games.Wordle.feedback("aaaaa", "aaaaa")
  [:green, :green, :green, :green, :green]

  iex> Games.Wordle.feedback("aaaaa", "aaaab")
  [:green, :green, :green, :green, :light_black]

  iex> Games.Wordle.feedback("abdce", "edcba")
  [:yellow, :yellow, :yellow, :yellow, :yellow]

  # If there are duplicate characters in the guess prioritize exact matches.
  iex> Games.Wordle.feedback("aaabb", "xaaaa")
  [:light_black, :green, :green, :yellow, :light_black]

  """
  def feedback(word, guess) do
    actual = word |> String.split("", trim: true)
    guess = guess |> String.split("", trim: true)

    {exact, guess_remaining, actual_remaining} = Enum.reduce(0..4, {%{}, %{}, %{}}, fn n, {exact, guess_remaining, actual_remaining} ->
      guess_letter = Enum.at(guess, n)
      actual_letter = Enum.at(actual, n)

      if guess_letter == actual_letter do
        {Map.put(exact, n, :green), guess_remaining, actual_remaining}
      else
        guess_remaining = Map.put(guess_remaining, n, guess_letter)
        actual_remaining = Map.put(actual_remaining, n, actual_letter)
        {exact, guess_remaining, actual_remaining}
      end
    end)

    actual_remaining = actual_remaining |> Map.values()

    {_, non_exact} = Enum.reduce(Map.keys(guess_remaining), {actual_remaining, %{}}, fn n, {actual_remaining, map} ->
      if guess_remaining[n] in actual_remaining do
        update_actual_remaining = List.delete(actual_remaining, guess_remaining[n])
        {update_actual_remaining, Map.put(map, n, :yellow)}
      else
        {actual_remaining, Map.put(map, n, :light_black)}
      end
    end)

    Map.merge(exact, non_exact)
    |> Map.values()
  end
end
