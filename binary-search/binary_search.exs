defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_search(numbers, key, 0, tuple_size(numbers))
  end

  defp do_search(_, _, s, e) when s == e, do: :not_foundd
  defp do_search(tuple, key, s, e) do
    mid_index = div(s + e, 2)
    mid = elem(tuple, mid_index)
    cond do
      key > mid && mid_index == s -> :not_found
      key > mid -> do_search(tuple, key, mid_index, e)
      key < mid && mid_index == e -> :not_found
      key < mid -> do_search(tuple, key, s, mid_index)
      true -> {:ok, mid_index}
    end
  end
end
