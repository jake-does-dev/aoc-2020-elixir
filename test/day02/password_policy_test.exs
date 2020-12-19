defmodule PasswordPolicyTest do
  use ExUnit.Case

  test "small case num occurrences" do
    data = FileReader.read_lines("test/day02/smallCase.txt")
    assert 2 == PasswordPolicy.num_valid_occurrence_based(data)
  end

  test "puzzle input num occurrences" do
    data = FileReader.read_lines("test/day02/puzzleInput.txt")
    assert 580 == PasswordPolicy.num_valid_occurrence_based(data)
  end

  test "small case position based" do
    data = FileReader.read_lines("test/day02/smallCase.txt")
    assert 1 == PasswordPolicy.num_valid_position_based(data)
  end

  test "puzzle input position based" do
    data = FileReader.read_lines("test/day02/puzzleInput.txt")
    assert 611 == PasswordPolicy.num_valid_position_based(data)
  end
end
