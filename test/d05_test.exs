defmodule Adventofcode2018.Test.D05Test do
  use ExUnit.Case

  test "example passes answer1" do
    input = "dabAcCaCBAcCcaDA"

    result = Adventofcode2018.D05.Answer.answer1(input)
    assert(result == 10)
  end

  test "example passes answer2" do
    input = "dabAcCaCBAcCcaDA"

    result = Adventofcode2018.D05.Answer.answer2(input)
    assert(result == 4)
  end
end
