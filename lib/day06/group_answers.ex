defmodule GroupAnswers do
  def sum_group_unique_answers(groups) do
    Enum.sum(
      for group <- groups do
        group
        |> String.split("\n")
        |> List.to_string()
        |> String.graphemes()
        |> Enum.uniq()
        |> length()
      end
    )
  end


end
