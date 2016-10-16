defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(white, black) when white == black, do: raise ArgumentError
  def new(white, black), do: %{white: white, black: black}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    w = do_cal(queens.white)
    b = do_cal(queens.black)

    do_to_string(0, w, b, "")
  end

  defp do_cal({r, c}), do: r * 8 + c

  defp do_to_string(64, _, _, acc), do: acc |> String.strip

  defp do_to_string(cur, w, b, acc) do
    cond do
      cur == w && is_last?(cur) -> do_to_string(cur + 1, w, b, acc <> "W\n")
      cur == w -> do_to_string(cur + 1, w, b, acc <> "W ")
      cur == b && is_last?(cur) -> do_to_string(cur + 1, w, b, acc <> "B\n")
      cur == b -> do_to_string(cur + 1, w, b, acc <> "B ")
      is_last?(cur) -> do_to_string(cur + 1, w, b, acc <> "_\n")
      true -> do_to_string(cur + 1, w, b, acc <> "_ ")
    end
  end

  defp is_last?(n), do: n != 0 && rem(n + 1, 8) == 0

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    w = do_cal(queens.white)
    b = do_cal(queens.black)

    {w_r, w_c} = queens.white
    {b_r, b_c} = queens.black

    w_r == b_r || w_c == b_c || rem(w, 9) == rem(b, 9) || rem(w, 7) == rem(b, 7)
  end
end
