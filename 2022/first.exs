demo_input_path = "/input/first_demo.txt"
input_path = "/input/first.txt"

defmodule ElfCalorieCounter do
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
  @input_path input_path

  defp add_string_int(nil, total), do: total
  defp add_string_int("", total), do: total
  defp add_string_int(string_int, total) do
    case String.trim(string_int) |> Integer.parse do
      {int, _} ->
        total + int
      :error ->
         IO.puts("[add_string_int] Bad input: #{string_int}")
         total
    end
  end

  defp parse_elf_cals({raw, index}) do
    calories = String.split(raw, "\n") 
      |> Enum.reduce(0, &add_string_int/2)
    {calories, index}
  end

  defp compare_tuples(entry, max) when is_nil(entry), do: max
  defp compare_tuples(entry, max) when is_nil(max) do
    parse_elf_cals(entry)
  end
  defp compare_tuples(entry, max) do
    {max_cals, _} = max
    parsed_entry = parse_elf_cals(entry)
    {entry_cals, _} = parsed_entry
    if entry_cals > max_cals, do: parsed_entry, else: max
  end

  defp parse_input(input_path) do
    File.read!(__DIR__ <> input_path)
    |> String.split("\n\n")
  end

  defp find_greediest_elf(elf_list) do
    {calories, index} = Enum.with_index(elf_list, 1)
    |> Enum.reduce(nil, &compare_tuples/2)
    {calories, List.delete_at(elf_list, index - 1)}
  end

  def run do
    IO.puts "Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?"
    
    elf_list = parse_input(@input_path)
    greediest_elf = find_greediest_elf(elf_list)
    {calories_1, elf_list_1} = greediest_elf
    IO.puts "* The greediest elf has #{calories_1}."
 
    {calories_2, elf_list_2} = find_greediest_elf(elf_list_1)
    IO.puts "* The second greediest elf has #{calories_2}."


    {calories_3, _} = find_greediest_elf(elf_list_2)
    IO.puts "* The third greediest elf has #{calories_3}."

    total = calories_1 + calories_2 + calories_3
    IO.puts "* In total they have #{total} calories"
  end

end

ElfCalorieCounter.run()
