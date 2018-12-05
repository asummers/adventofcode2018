defmodule Adventofcode2018.D02.Answer do
  @input "priv/d02.txt"

  def answer1() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> do_answer1()
  end

  def answer1(numbers) when is_list(numbers) do
    do_answer1(numbers)
  end

  defp do_answer1(input) do
    input
    |> Enum.flat_map(fn letters ->
      letters
      |> String.graphemes()
      |> Enum.reduce(%{}, fn char, acc ->
        Map.update(acc, char, 1, &(&1 + 1))
      end)
      |> Enum.map(fn {_, count} -> count end)
      |> Enum.filter(fn count -> count > 1 end)
      |> Enum.uniq()
    end)
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
    |> Map.values()
    |> Enum.reduce(1, &Kernel.*/2)
  end

  def answer2() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> do_answer2()
  end

  def answer2(input) do
    do_answer2(input)
  end

  defp do_answer2(input) do
    {key, val} =
      input
      |> Enum.map(fn input_line ->
        single_differences =
          Enum.filter(input, fn letters ->
            difference = String.myers_difference(input_line, letters)
            single_letter_insert? =
              difference
              |> Keyword.get_values(:ins)
              |> single_letter_modification?()

            single_letter_delete? =
              difference
              |> Keyword.get_values(:del)
              |> single_letter_modification?()

            single_letter_insert? && single_letter_delete?
          end)

        {input_line, single_differences}
      end)
      |> Enum.find(fn {_line, similarities} -> Enum.count(similarities) == 1 end)

    key
    |> String.myers_difference(hd(val))
    |> Keyword.delete(:ins)
    |> Keyword.delete(:del)
    |> Keyword.get_values(:eq)
    |> Enum.join()
  end

  defp single_letter_modification?(ins_or_del) do
    (Enum.count(ins_or_del) == 1) && (ins_or_del |> hd |> String.split("", trim: true) |> Enum.count() == 1)
  end
end
