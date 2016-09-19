defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    (Map.get(db, grade) || [])
    |> add_to_set(name)
    |> update_school(db, grade)
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
      Map.get(db, grade) || []
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    db
    |> Map.keys
    |> Enum.sort
    |> Enum.map fn(key) ->
      Map.get(db, key)
      |> Enum.sort
      |> (fn(list) ->
        {key, list}
      end).()
    end
  end

  defp add_to_set(list, val) do
    list ++ [val]
    |> Enum.uniq
  end

  defp update_school(list, db, grade) do
    Map.update(db, grade, list, fn(_) -> list end)
  end
end
