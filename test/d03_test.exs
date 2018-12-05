defmodule Adventofcode2018.Test.D03_Test do
  use ExUnit.Case

  test "example passes answer1" do
    input = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]

    result = Adventofcode2018.D03.Answer.answer1(input)
    assert(result == 4)
  end

  test "example passes answer2" do
    input = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]

    result = Adventofcode2018.D03.Answer.answer2(input)
    assert(result == 3)
  end
end
