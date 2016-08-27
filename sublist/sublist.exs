defmodule Sublist do
  def compare(a, b) do
    cond do
      length(a) > length(b) ->
        check_superlist(a, b)
      length(a) < length(b) ->
        check_sublist(a, b)
      true ->
        check_equal(a, b);
    end

  end

  defp check_sublist([], _) do
    :sublist
  end

  defp check_sublist(a, b) do
    check_sublist(a, b, length(a), length(b))
  end

  defp check_sublist(_, [], _, _) do
    :unequal
  end

  defp check_sublist(a, b, al, bl) do
    first_of_a = List.first a

    index = Enum.find_index(b, fn(x) -> x === first_of_a end) || bl

    substring = Enum.slice(b, index..(index + al - 1))

    remain_b = Enum.slice(b, (index + 1)..-1)

    cond do
      a === substring -> :sublist
      true -> check_sublist(a, remain_b, al, bl)
    end
  end

  defp check_superlist(_, []) do
    :superlist
  end

  defp check_superlist(a, b) do
    cond do
      check_sublist(b, a) == :sublist -> :superlist
      true -> :unequal
    end
  end

  defp check_equal(a, b) do
    cond do
      a == b -> :equal
      true -> :unequal
    end
  end
end
