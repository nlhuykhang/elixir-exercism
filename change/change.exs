defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    sorted_valued = Enum.sort(values)
    last = List.last(sorted_valued)
    list = List.delete(sorted_valued, last)

    do_generate(amount, 0, list, last, %{}, list)
  end

  defp do_generate(_, _, _, nil, _, []) do
    :error
  end

  defp do_generate(amount, _, _, nil, re, oriList) do
    nextLast = List.last(oriList)
    nextList = List.delete(oriList, nextLast)

    do_generate(amount, 0, nextList, nextLast, all_values_to_zero(re), nextList)
  end

  defp do_generate(amount, curSum, list, curLast, re, oriList) do
    cond do
      amount == curSum -> {:ok, re}
      amount >= (curSum + curLast) ->
        do_generate(amount, curSum + curLast, list, curLast, Map.update(re, curLast, 1, &(&1 + 1)), oriList)
      true ->
        nextLast = List.last(list)
        nextList = List.delete(list, nextLast)
        do_generate(amount, curSum, nextList, nextLast, Map.update(re, curLast, 0, &(&1)), oriList)
    end
  end

  defp all_values_to_zero(map) do
    for {k, _} <- map, into: %{}, do: {k, 0}
  end

end
