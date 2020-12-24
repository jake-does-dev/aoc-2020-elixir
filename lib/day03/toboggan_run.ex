defmodule TobogganRun do
  defmodule Step do
    defstruct right: 0,
              down: 0

    @type t :: %Step{right: integer, down: integer}
  end

  defmodule Position do
    defstruct horiz: 0,
              depth: 0

    @type t :: %Position{horiz: integer, depth: integer}
  end

  @spec multiply_trees(list(String.t()), Step.t()) :: integer
  def multiply_trees(steps, slope) do
    steps
    |> Enum.map(fn s -> count_trees(s, slope) end)
    |> Enum.reduce(&(&1 * &2))
  end

  @spec count_trees(Step.t(), list(String.t()), Position.t(), integer) :: integer
  def count_trees(step, slope, position \\ %Position{}, tree_count \\ 0)

  def count_trees(step, slope, position, _) when position == %Position{} do
    count_trees(
      step,
      slope,
      %Position{
        horiz: step.right,
        depth: step.down
      },
      0
    )
  end

  def count_trees(step, slope, position, tree_count) when position.depth < length(slope) do
    line = String.codepoints(Enum.at(slope, position.depth))

    tree =
      line
      |> Enum.at(position.horiz)
      |> case do
        "#" -> 1
        _ -> 0
      end

    count_trees(
      step,
      slope,
      %Position{
        horiz: rem(position.horiz + step.right, length(line)),
        depth: position.depth + step.down
      },
      tree_count + tree
    )
  end

  def count_trees(_, _, _, tree_count) do
    tree_count
  end
end
