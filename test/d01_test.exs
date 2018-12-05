defmodule Adventofcode2018.Test.D01_Test do
  use ExUnit.Case

  test "first example passes answer1" do
    result = Adventofcode2018.D01.Answer.answer1(["+1", "+1", "+1"])
    assert(result == 3)
  end

  test "second example passes answer1" do
    result = Adventofcode2018.D01.Answer.answer1(["+1", "+1", "-2"])
    assert(result == 0)
  end

  test "third example passes answer1" do
    result = Adventofcode2018.D01.Answer.answer1(["-1", "-2", "-3"])
    assert(result == -6)
  end

  test "first example passes answer2" do
    result = Adventofcode2018.D01.Answer.answer2(["+1", "-1"])
    assert(result == 0)
  end

  test "second example passes answer2" do
    result = Adventofcode2018.D01.Answer.answer2(["+3", "+3", "+4", "-2", "-4"])
    assert(result == 10)
  end

  test "third example passes answer2" do
    result = Adventofcode2018.D01.Answer.answer2(["-6", "+3", "+8", "+5", "-6"])
    assert(result == 5)
  end

  test "fourth example passes answer2" do
    result = Adventofcode2018.D01.Answer.answer2(["+7", "+7", "-2", "-7", "-4"])
    assert(result == 14)
  end
end
