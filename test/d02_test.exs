defmodule Adventofcode2018.Test.D02_Test do
  use ExUnit.Case

  test "example passes answer1" do
    input = [
      "abcdef",
      "bababc",
      "abbcde",
      "abcccd",
      "aabcdd",
      "abcdee",
      "ababab"
    ]

    result = Adventofcode2018.D02.Answer.answer1(input)
    assert(result == 12)
  end

  test "example passes answer2" do
    input = ["abcde", "klmno", "pqrst", "fguij", "axcye", "wvxyz", "fghij"]

    result = Adventofcode2018.D02.Answer.answer2(input)
    assert(result == "fgij")
  end
end
