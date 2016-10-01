defmodule Garden do
  @map %{
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
    "V" => :violets
  }

  @default_students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @map) do
    info_string
    |> String.split
    |> Enum.map(fn(l) -> to_plants(l) end)
  end

  defp to_plants(str) do
    str
    |> String.codepoints
    |> Enum.map(fn(c) -> @map[c] end)
  end
end
