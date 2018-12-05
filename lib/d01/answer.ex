defmodule Adventofcode2018.D01.Answer do
  @input "priv/d01.txt"

  def answer1() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> do_answer1()
  end

  def answer1(numbers) when is_list(numbers) do
    do_answer1(numbers)
  end

  defp do_answer1(numbers) do
    numbers
    |> Enum.map(fn input ->
      {parsed, ""} = Integer.parse(input)
      parsed
    end)
    |> Enum.sum()
  end

  def answer2() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> do_answer2()
  end

  def answer2(numbers) when is_list(numbers) do
    do_answer2(numbers)
  end

  defp do_answer2(enum) do
    enum
    |> Stream.cycle()
    |> Stream.map(fn input ->
      {parsed, ""} = Integer.parse(input)
      parsed
    end)
    |> Stream.transform({0, MapSet.new()}, fn parsed, {partial_sum, seen} ->
      if MapSet.member?(seen, partial_sum) do
        {:halt, seen}
      else
        sum = partial_sum + parsed
        {[parsed], {sum, MapSet.put(seen, partial_sum)}}
      end
    end)
    |> Enum.to_list()
    |> Enum.sum()
  end
end
