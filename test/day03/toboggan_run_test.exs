defmodule TobogganRunTest do
  use ExUnit.Case
  alias TobogganRun.Step

  test "small case right 3 down 1" do
    slope = FileReader.read_lines("test/day03/smallCase.txt")
    step = %Step{right: 3, down: 1}

    assert 7 == TobogganRun.count_trees(step, slope)
  end

  test "puzzle input right 3 down 1" do
    slope = FileReader.read_lines("test/day03/puzzleInput.txt")
    step = %Step{right: 3, down: 1}

    assert 162 == TobogganRun.count_trees(step, slope)
  end

  test "small case tree product" do
    slope = FileReader.read_lines("test/day03/smallCase.txt")

    steps = [
      %Step{right: 1, down: 1},
      %Step{right: 3, down: 1},
      %Step{right: 5, down: 1},
      %Step{right: 7, down: 1},
      %Step{right: 1, down: 2}
    ]

    assert 336 == TobogganRun.multiply_trees(steps, slope)
  end

  test "puzzle input tree product" do
    slope = FileReader.read_lines("test/day03/puzzleInput.txt")

    steps = [
      %Step{right: 1, down: 1},
      %Step{right: 3, down: 1},
      %Step{right: 5, down: 1},
      %Step{right: 7, down: 1},
      %Step{right: 1, down: 2}
    ]

    assert 3_064_612_320 == TobogganRun.multiply_trees(steps, slope)
  end
end
