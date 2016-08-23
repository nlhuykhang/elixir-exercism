defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
      |> String.split([" ", "-"])
      |> Enum.map(
        fn(w) ->
          w
            |> String.split("")
            |> Enum.with_index
            |> Enum.filter(fn(x) -> isUpcase(x) || isFirst(x) end)
            |> Enum.map(fn(x) -> elem(x, 0) end)
        end
      )
      |> List.flatten
      |> Enum.map_join(fn(w) -> String.first(w) end)
      |> String.upcase
  end

  def isUpcase(w) do
    elem(w, 0) =~ ~r/^\p{Lu}$/u
  end

  def isFirst(w) do
    case w do
      {_, 0} -> true
      _ -> false
    end
  end

end
