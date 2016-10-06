defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @map %{
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday,
  }

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    cond do
      schedule == :teenth -> do_teenth(year, month, weekday, 13)
      schedule == :first -> do_first(year, month, weekday, 1)
      schedule == :second -> do_first(year, month, weekday, 8)
      schedule == :third -> do_first(year, month, weekday, 15)
      schedule == :fourth -> do_first(year, month, weekday, 22)
      true -> do_last(year, month, weekday, :calendar.last_day_of_the_month(year, month))
    end

  end

  defp do_teenth(year, month, _, 19) do
    {year, month, 19}
  end

  defp do_teenth(year, month, weekday, day) do
    a = :calendar.day_of_the_week(year, month, day)
    cond do
      @map[a] == weekday -> {year, month, day}
      true -> do_teenth(year,  month, weekday, day + 1)
    end

  end

  defp do_first(year, month, _, 31) do
    {year, month, 31}
  end

  defp do_first(year, month, weekday, cur) do
    a = :calendar.day_of_the_week(year, month, cur)
    cond do
      @map[a] == weekday -> {year, month, cur}
      true -> do_first(year,  month, weekday, cur + 1)
    end
  end

  defp do_last(year, month, _, 22) do
    {year, month, 22}
  end

  defp do_last(year, month, weekday, day) do
    a = :calendar.day_of_the_week(year, month, day)
    cond do
      @map[a] == weekday -> {year, month, day}
      true -> do_last(year,  month, weekday, day - 1)
    end
  end
end
