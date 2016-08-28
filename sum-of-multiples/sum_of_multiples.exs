defmodule SumOfMultiples do

  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(fn(x) -> {x, div(limit - 1, x)} end)
    |> Enum.map(fn(x) -> to_list_of_multiples(x) end)
    |> List.flatten
    |> Enum.uniq
    |> Enum.sum
  end

  defp to_list_of_multiples({number, times}) do
    to_list_of_multiples({number, times}, [])
  end

  defp to_list_of_multiples({_, 0}, l) do
    l
  end

  defp to_list_of_multiples({number, times}, l) do
    to_list_of_multiples({number, times - 1}, l ++ [number * times])
  end

end
