defmodule Concentrese do
  @vowels ["A", "E", "I", "O", "U"]
  @consonants ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M",
               "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]

  defstruct board: [], pairs: [], lives: 4, score: 0, streak: 0

  def play do
    board = create_board()
    game_loop(%Concentrese{board: board})
  end

  def create_board do
    vowels = Enum.take_random(@vowels, 3)
    consonants = Enum.take_random(@consonants, 3)
    (vowels ++ consonants ++ vowels ++ consonants)
    |> Enum.shuffle()
    |> Enum.map(&{&1, :hidden})
  end

  def game_loop(state) do
    display_board(state.board)
    IO.puts "Lives: #{state.lives} | Score: #{state.score} | Streak: #{state.streak}"

    case read_pair() do
      nil -> game_over(state, "Thanks for playing!")
      pair when pair in state.pairs -> game_loop(state)
      pair when correct_pair?(pair) ->
        new_state = state
                    |> update_board(pair)
                    |> increase_score(pair)
                    |> update_streak(pair)
                    |> add_pair(pair)
        if all_pairs_found?(new_state.board) do
          game_over(new_state, "Congratulations! You won!")
        else
          game_loop(new_state)
        end
      _ ->
        new_state = state |> decrement_lives()
        if new_state.lives == 0 do
          game_over(new_state, "Game over! Better luck next time.")
        else
          game_loop(new_state)
        end
    end
  end

  def read_pair do
    IO.puts "Enter a pair of letters (e.g. Aa):"
    case String.upcase(IO.gets("")), String.upcase(IO.gets("")) do
      {letter1, letter2} when letter1 in @vowels and letter2 in @vowels ->
        {letter1, letter2}
      {letter1, letter2} when letter1 in @consonants and letter2 in @consonants ->
        {letter1, letter2}
      _ ->
        IO.puts "Invalid pair. Please enter two letters of the same type (vowel or consonant)."
        read_pair()
    end
  end

  def correct_pair?({letter1, letter2}) do
    letter1 == letter2
  end

  def update_board({letter1, letter2}, state) do
    pairs = state.pairs ++ [{letter1, letter2}]
    board = state.board
              |> Enum.map(fn
                {letter, :hidden} when letter == letter1 or letter == letter2 ->
                  {letter, :revealed}
                card -> card
              end)
    %{state | board: board, pairs: pairs}
  end

  def increase_score({letter1, letter2}, state) do
    case {letter1, letter2} do
      {letter, _} when letter in @vowels -> %{state | score: state.score + 15}
      {_, letter} when letter in @vowels
            {_, _} -> %{state | score: state.score + 10}
    end
  end

  def update_streak(_, %{streak: 0} = state), do: state
  def update_streak(_, %{streak: streak, score: score} = state) when streak == 0, do: state
  def update_streak({letter1, letter2}, %{streak: streak, score: score} = state) do
    if streak > 0 and List.last(state.pairs) == {letter1, letter2} do
      %{state | streak: streak + 1, score: score + (streak + 1) * 10}
    else
      %{state | streak: 1}
    end
  end

  def add_pair(pair, state) do
    %{state | pairs: state.pairs ++ [pair]}
  end

  def decrement_lives(state) do
    %{state | lives: state.lives - 1}
  end

  def all_pairs_found?(board) do
    Enum.all?(board, fn {_, status} -> status == :revealed end)
  end

  def display_board(board) do
    board
    |> Enum.chunk(4)
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn {letter, status} ->
        case status do
          :hidden -> "?"
          :revealed -> letter
        end
      end)
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def game_over(state, message) do
    display_board(state.board)
    IO.puts message
    IO.puts "Final score: #{state.score} | Maximum streak: #{state.streak}"
    :ok
  end
end

Concentrese.play
