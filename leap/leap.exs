defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    cond do
      d_by_4(year) && d_by_100(year) && d_by_400(year) -> true
      d_by_4(year) && d_by_100(year) && !d_by_400(year) -> false
      d_by_4(year) -> true
      true -> false
    end
  end

  defp d_by_4(n) do
    rem(n, 4) == 0
  end

  defp d_by_100(n) do
    rem(n, 100) == 0
  end

  defp d_by_400(n) do
    rem(n, 400) == 0
  end
end
