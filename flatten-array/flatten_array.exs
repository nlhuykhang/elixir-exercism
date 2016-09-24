defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    Enum.reduce(list, [], fn(x, acc) -> tired(x, acc) end)
  end

  defp tired(x, acc) do
    cond do
      is_nil(x) -> acc
      is_list(x) -> Enum.reduce(x, acc, fn(x, acc) -> tired(x, acc) end)
      true -> acc ++ [x]
    end
  end
end
