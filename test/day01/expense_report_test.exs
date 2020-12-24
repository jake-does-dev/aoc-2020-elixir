defmodule ExpenseReportTest do
  use ExUnit.Case

  test "small case pair" do
    data = FileReader.read_ints("test/day01/smallCase.txt")
    assert 514_579 == ExpenseReport.find_multiple_of_pair(data, 2020)
  end

  test "puzzle input pair" do
    data = FileReader.read_ints("test/day01/puzzleInput.txt")
    assert 1_007_104 == ExpenseReport.find_multiple_of_pair(data, 2020)
  end

  test "small case triple" do
    data = FileReader.read_ints("test/day01/smallCase.txt")
    assert 241_861_950 == ExpenseReport.find_multiple_of_triple(data, 2020)
  end

  test "puzzle input triple" do
    data = FileReader.read_ints("test/day01/puzzleInput.txt")
    assert 18_847_752 == ExpenseReport.find_multiple_of_triple(data, 2020)
  end
end
