defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_gen(1, num, [])
  end

  defp do_gen(_, 1, _), do: [[1]]
  defp do_gen(_, 2, _), do: [[1], [1, 1]]

  defp do_gen(cur, num, acc) do
    cond do
      cur == 1 -> do_gen(cur + 1, num, [[1] | acc])
      cur == 2 -> do_gen(cur + 1, num, [[1, 1] | acc])
      cur > num -> Enum.reverse(acc)
      true ->
        List.first(acc)
        |> cal([])
        |> (fn(list) ->
          do_gen(cur + 1, num, [ [1] ++ list ++ [1]| acc])
        end).()
    end
  end

  defp cal([_ | []], acc), do: acc

  defp cal([h | t], acc), do: cal(t, [h + List.first(t) | acc])
end
