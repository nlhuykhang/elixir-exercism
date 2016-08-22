defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      |> String.replace(~r/[^\w|-]|_/u, " ")
      |> String.split
      |> Enum.reduce(
          %{},
          fn(x, acc) ->
            Map.update(acc, x, 1, fn cr -> cr + 1 end)
          end
        )
  end
end
