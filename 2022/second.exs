defmodule RockPaperScissorsStrategist do
  @input_path "/input/second.txt"
  @demo_input_path "/input/second_demo.txt"

  @moduledoc """
  The Elves are having a giant Rock-Paper-Scissors Tournament!

  The winner of the whole tournament is the player with the highest score. 
  Your total score is the sum of your scores for each round. 
  The score for a single round is the score for the shape you selected 
  (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome 
  of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
  """

  def relative_input_path(is_demo \\ false) do
    if (is_demo) do
      __DIR__ <> @demo_input_path
    else
      __DIR__ <> @input_path
    end
  end

  defp score_shape(value) do
    case value do
      v when v in ["A", "X"] -> 1
      v when v in ["B", "Y"] -> 2
      v when v in ["C", "Z"] -> 3
      _ ->
       IO.puts "Invalid input! #{value}"
       -1
    end
  end

  defp score_win_loss(their_points, my_points) do  
    if (my_points > their_points), do: 6
    if (my_points === their_points), do: 3
    0
  end

  defp score_round(values) do
    scored_values = Enum.map(values, &score_shape/1)
    shape_points = tl(scored_values)
    win_loss_points = score_win_loss(hd(shape_points), tl(shape_points))
    
    shape_points + win_loss_points
  end

  defp parse_input_line(raw) do
    String.trim(raw)
    |> String.split(" ")
    |> Enum.map(&IO.inspect/1)
    |> Enum.map(&score_shape/1)
    |> Enum.map(&IO.inspect/1)
  end

  defp parse_input(is_demo \\ false) do
    relative_input_path(is_demo)
    |> File.stream!
    |> Stream.map(&parse_input_line/1)
    |> Stream.run
  end

  def run do
    IO.puts "Rock - Paper - Scissors!!!"
    parse_input(true)

    IO.puts "What would your total score be if everything goes exactly according to your strategy guide?"
  end
end

RockPaperScissorsStrategist.run()