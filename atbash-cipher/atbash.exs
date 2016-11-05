defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    Regex.replace(~r/[\s,.]/, plaintext, "")
    |> String.downcase
    |> to_charlist
    |> Enum.with_index
    |> Enum.map(&do_job/1)
    |> to_string
    |> String.trim
  end

  defp do_job({c, i}) do
    cond do
      rem(i + 1, 5) == 0 -> [convert_char(c), 32]
      true -> convert_char(c)
    end
  end

  defp convert_char(c) do
    cond do
      c >= 48 && c <= 57 -> c
      true -> ?z - (c - ?a)
    end
  end
end
