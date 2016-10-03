defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    keys = Map.keys input
    values = Map.values input

    do_job(keys, values, %{})
  end

  defp do_job([], [], re) do
    re
  end

  defp do_job([kh | kt], [vh | vt], re) do
    do_job(kt, vt, update_map(kh, vh, re))
  end

  defp update_map(_, [], re) do
    re
  end

  defp update_map(key, [h | t], re) do
    update_map(
      key,
      t,
      Map.put(re, String.downcase(h), key)
    )
  end
end
