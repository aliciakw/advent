demo_input_path = "./input/first_demo.txt"
input_path = "./input/first.txt"

defmodule ElfCalorieCounter do
  @input_path demo_input_path
  @moduledoc """
    This list represents the Calories of the food carried by five Elves:

    The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
    The second Elf is carrying one food item with 4000 Calories.
    The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
    The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
    The fifth Elf is carrying one food item with 10000 Calories.
    In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: they'd like to know how many Calories are being carried by the Elf carrying the most Calories. In the example above, this is 24000 (carried by the fourth Elf).

    Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
  """

  defp parse_input(raw) do
    String.split(raw, "\n\n") |> Enum.map(fn(x) ->
      string_arr = String.split(x, "\n")
      num_arr = string_arr |> Enum.map(fn(y) ->  {num, _} = Integer.parse(y); num end)
      Enum.sum(num_arr)
    end)
  end

  defp compare_tuples(a, b) when is_nil(a), do: b
  defp compare_tuples(a, b) when is_nil(b), do: a
  defp compare_tuples(a, b) do
    {max_a, _} = a
    {max_b, _} = b
    if max_b > max_a, do: b, else: a
  end


  defp find_max(arr) do
    Enum.with_index(arr, 1)
    |> Enum.reduce(nil, &compare_tuples/2)
  end

  def run do
    IO.puts "Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?"

    {:ok, input} = File.read(@input_path)

    elf_calories = parse_input(input)
   
    IO.inspect(elf_calories)

    {calories, index} = find_max(elf_calories)
    IO.puts "Elf ##{index} is carrying the most calories (#{calories})."
  end

end

ElfCalorieCounter.run()
