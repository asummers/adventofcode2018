defmodule Adventofcode2018.D05.Answer do
  @input "priv/d05.txt"

  def answer1() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> hd()
    |> do_answer1()
  end

  def answer1(str) do
    do_answer1(str)
  end

  defp do_answer1(str) when is_bitstring(str) do
    Stream.resource(
      fn -> {String.split(str, "", trim: true), []} end,
      &squash/1,
      fn _ -> :ok end
    )
    |> Enum.to_list()
    |> Enum.count()
  end

  defp squash(:halted) do
    {:halt, nil}
  end

  defp squash({[], previous}) do
    letters = Enum.reverse(previous)
    {letters, :halted}
  end

  defp squash({[first | [second | []]], previous}) do
    if should_squash?(first, second) do
      next = previous
      next_previous = []

      {[], {next, next_previous}}
    else
      next = []
      next_previous = [second | [first | previous]]

      {[], {next, next_previous}}
    end
  end

  defp squash({[first | [second | rest]], previous}) do
    if should_squash?(first, second) do
      # TODO: Can be more clever here and only consider previous, or
      # something like that and not have to start over for performance
      # reasons
      next =
        previous
        |> Enum.reverse()
        |> Enum.concat(rest)
      next_previous = []

      {[], {next, next_previous}}
    else
      next = [second | rest]
      next_previous = [first | previous]

      {[], {next, next_previous}}
    end
  end

  defp should_squash?(first, second) do
    first != second && String.upcase(first) == String.upcase(second)
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

  defp do_answer2(_rows) do

  end
end