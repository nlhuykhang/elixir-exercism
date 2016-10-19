defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&split_to_number/1)
  end

  defp split_to_number(str) do
    str
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> do_columns
  end

  defp do_columns(rows), do: do_columns(rows, [], [], [])
  defp do_columns([], rem, acc1, acc2) do
    cond do
      List.flatten(rem) == [] -> acc2 ++ [acc1]
      true -> do_columns(rem, [], [], acc2 ++ [acc1])
    end
  end
  defp do_columns([[h | t1] | t2], rem, acc1, acc2), do: do_columns(t2, rem ++ [t1], acc1 ++ [h], acc2)

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    columns = do_columns(rows)

    c1 = rows
    |> Enum.map(&convert_max/1)
    |> do_columns

    c2 = columns
    |> Enum.map(&convert_min/1)

    compare_1(c2, c1, [])
  end

  defp compare_1([], [], acc), do: acc
  defp compare_1([h1 | t1], [h2 | t2], acc), do: compare_1(t1, t2, acc ++ compare_2(h1, h2, []))

  defp compare_2([], [], acc), do: acc
  defp compare_2([h1 | t1], [h2 | t2], acc) do
    cond do
      h1 == false || h2 == false -> compare_2(t1, t2, acc)
      true -> compare_2(t1, t2, acc ++ [{h1, h2}])
    end
  end

  defp convert_max(ele) do
    max = Enum.max(ele)
    ele
    |> Enum.with_index
    |> Enum.map(fn({v, i}) ->
      cond do
        v == max -> i
        true -> false
      end
    end)
  end

  defp convert_min(ele) do
    min = Enum.min(ele)
    ele
    |> Enum.with_index
    |> Enum.map(fn({v, i}) ->
      cond do
        v == min -> i
        true -> false
      end
    end)
  end
end
