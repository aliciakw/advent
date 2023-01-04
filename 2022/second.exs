defmodule RockPaperScissorsStrategist do
  @input_path "/input/second.txt"
  @demo_input_path "/input/second_demo.txt"

  def relative_input_path(is_demo \\ false) do
    if (is_demo) do
      __DIR__ <> @demo_input_path
    else
      __DIR__ <> @input_path
    end
  end

  defp parse_input(is_demo \\ false) do
    input_path = relative_input_path(is_demo)

    File.stream!(input_path)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&IO.puts/1)
    # |> Stream.map(fn ({line, index}) -> IO.puts "#{index + 1} #{line}" end)
    |> Stream.run
  end

  def run do
    IO.puts "Rock - Paper - Scissors!!!"
    parse_input(true)
  end
end

RockPaperScissorsStrategist.run()