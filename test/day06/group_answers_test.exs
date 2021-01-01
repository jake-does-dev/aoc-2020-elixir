defmodule GroupAnswersTest do
  use ExUnit.Case

  test "anyone answered small case" do
    groups = FileReader.read_lines("test/day06/smallCase.txt", "\n\n")
    assert 11 == GroupAnswers.sum_group_unique_answers(groups)
  end

  test "anyone answered puzzle input" do
    groups = FileReader.read_lines("test/day06/puzzleInput.txt", "\n\n")
    assert 6778 == GroupAnswers.sum_group_unique_answers(groups)
  end
end
