defmodule Gigasecond do
  @day 11574
  @hour 1
  @minute 46
  @second 40

  @day_of_month_map %{
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
  }

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    add_day({year, month, day}, {hours, minutes, seconds})
    |> re_format
  end

  defp add_day({year, month, day}, {hours, minutes, seconds}) do
    correct({year, month, day + @day, hours + @hour, minutes + @minute, seconds + @second})
  end

  defp re_format({year, month, day, hours, minutes, seconds}), do: {{year, month, day}, {hours, minutes, seconds}}

  defp correct({y, mo, d, h, mi, s}) do
    cond do
      s > 59 -> correct({y, mo, d, h, mi + 1, s - 60})
      mi > 59 -> correct({y, mo, d, h + 1, mi - 60, s})
      h > 23 -> correct({y, mo, d + 1, h - 24, mi, s})
      d > get_last_day_of_month({y, mo}) -> correct({y, mo + 1, d - get_last_day_of_month({y, mo}), h, mi, s})
      mo > 12 -> correct({y + 1, mo - 12, d, h, mi, s})
      true -> {y, mo, d, h, mi, s}
    end
  end

  defp get_last_day_of_month({year, month}) do
    cond do
      Calendar.ISO.leap_year?(year) && month == 2 -> 29
      true -> @day_of_month_map[month]
    end
  end
end
