defmodule Adventofcode2018.D04.Answer do
  @input "priv/d04.txt"

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
    [date, activity] = String.split(line, ["[", "]"], trim: true)
    activity = String.trim_leading(activity)

    [year, month, day, hour, minute] =
      date
      |> String.split(["-", " ", ":"], trim: true)
      |> Enum.map(&parseint!/1)

    %{year: year, month: month, day: day, hour: hour, minute: minute, activity: activity}
  end

  defp guard_activities(rows) do
    rows
    |> Enum.sort()
    |> Enum.map(&parse/1)
    |> Enum.reduce(%{guard: nil}, fn parsed, result ->
      %{year: year, month: month, day: day, hour: hour, minute: minute, activity: activity} =
        parsed

      {:ok, naive} = NaiveDateTime.new(year, month, day, hour, minute, 0)
      {:ok, time} = DateTime.from_naive(naive, "Etc/UTC")

      case activity do
        "Guard #" <> rest ->
          guard =
            rest
            |> String.split(" ")
            |> hd()
            |> parseint!()

          result
          |> Map.put(:guard, guard)
          |> Map.put_new(guard, [])

        "falls asleep" ->
          guard = Map.get(result, :guard)
          guard_activities = Map.get(result, guard, [])
          Map.put(result, guard, [%{asleep: time} | guard_activities])

        "wakes up" ->
          guard = Map.get(result, :guard)
          guard_activities = Map.get(result, guard, [])
          Map.put(result, guard, [%{awake: time} | guard_activities])
      end
    end)
    |> Map.delete(:guard)
  end

  defp do_answer1(rows) do
    guard_activities = guard_activities(rows)

    sleepiest = sleepiest(guard_activities)

    when_sleepiest =
      guard_activities
      |> Map.get(sleepiest)
      |> when_sleepiest()

    sleepiest * when_sleepiest
  end

  defp when_sleepiest(activities) do
    {minute, _count} =
      activities
      |> minutes_asleep()
      |> Enum.max_by(fn {_, count} -> count end)

    minute
  end

  defp sleepiest(guard_activities) do
    {guard, _activities} =
      Enum.max_by(guard_activities, fn {_, activities} ->
        activities
        |> minutes_asleep()
        |> Enum.map(fn {_, count} -> count end)
        |> Enum.sum()
      end)

    guard
  end

  defp minutes_asleep(activities) do
    activities
    |> Enum.chunk_every(2)
    |> Enum.reduce(%{}, fn [%{awake: to}, %{asleep: from}], acc ->
      Enum.reduce(from.minute..(to.minute - 1), acc, fn minute, acc ->
        Map.update(acc, minute, 1, &(&1 + 1))
      end)
    end)
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
    {guard, {minute, count}} =
      rows
      |> guard_activities()
      |> Enum.map(fn {guard, activities} ->
        {guard, minutes_asleep(activities)}
      end)
      |> Enum.reject(fn {_, activities} -> Enum.empty?(activities) end)
      |> Enum.map(fn {guard, minutes} ->
        {minute, count} = Enum.max_by(minutes, fn {_, count} -> count end)
        {guard, {minute, count}}
      end)
      |> Enum.max_by(fn {_, {minute, count}} -> count end)

    guard * minute
  end
end
