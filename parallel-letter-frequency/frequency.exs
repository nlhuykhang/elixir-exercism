defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> divide(workers)
    |> Enum.map(fn(list) ->
      Task.async(fn -> do_frequency(list) end)
    end)
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(%{}, fn(m, acc) -> Map.merge(m, acc, fn(_k, v1, v2) -> v1 + v2 end) end)
  end

  defp do_merge() do

  end

  defp do_frequency(list) do
    list
    |> Enum.join
    |> (fn str -> Regex.replace(~r/(\W|\d)/u, str, "") end).()
    |> String.trim
    |> String.downcase
    |> String.codepoints
    |> Enum.reduce(%{}, fn(c, acc) -> Map.update(acc, c, 1, &(&1 + 1)) end)
  end

  defp divide(lines, n) do
    do_divide(lines, List.duplicate([], n), [])
  end

  defp do_divide([], o1, o2), do: o1 ++ o2
  defp do_divide([l|ls], [o|o1], o2), do: do_divide(ls, o1, [[l|o]|o2])
  defp do_divide(ls, [], o2), do: do_divide(ls, o2, [])
end
