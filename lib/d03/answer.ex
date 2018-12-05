defmodule Adventofcode2018.D03.Answer do
  @input "priv/d03.txt"

  defp parseint!(str) do
    {parsed, ""} = Integer.parse(str)
    parsed
  end

  def answer1() do
    @input
    |> File.read!()
    |> String.split("\n", trim: true)
    |> do_answer1()
  end

  def answer1(rows) when is_list(rows) do
    do_answer1(rows)
  end

  # Example: #1 @ 1,3: 4x4
  defp parse(line) do
    [id, x, y, w, h] =
      line
      |> String.split(["#", " ", "@", ",", ":", "x"], trim: true)
      |> Enum.map(&parseint!/1)

    %{id: id, x: x, y: y, w: w, h: h}
  end

  defp claim_rows(rows) do
    Enum.reduce(rows, %{}, fn row, claimed ->
      %{id: id, x: x, y: y, w: w, h: h} = parse(row)

      # eww.
      (x + 1)..(x + w)
      |> Enum.flat_map(fn x1 ->
        Enum.map((y + 1)..(y + h), fn y1 -> {x1, y1} end)
      end)
      |> Enum.reduce(claimed, &claim(&1, &2, id))
    end)
  end

  defp claim(coordinate, claimed, id) do
    Map.update(claimed, coordinate, [id], fn claimed_ids -> [id | claimed_ids] end)
  end

  defp do_answer1(rows) do
    rows
    |> claim_rows()
    |> Enum.filter(fn {_, ids} -> Enum.count(ids) > 1 end)
    |> Enum.count()
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

  defp do_answer2(rows) do
    claimed = claim_rows(rows)

    claimed
    |> Enum.filter(fn {_, ids} -> Enum.count(ids) == 1 end)
    |> Enum.flat_map(fn {_, ids} -> ids end)
    |> Enum.uniq()
    |> Enum.find(fn id ->
      Enum.all?(claimed, fn {_, ids} ->
        !Enum.member?(ids, id) || Enum.count(ids) == 1
      end)
    end)
  end
end
