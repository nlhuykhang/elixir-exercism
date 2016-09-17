defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    cond do
      number == 3 -> """
2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.
      """
      number == 2 -> """
#{number - 1} bottle of beer on the wall, #{number - 1} bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
      """
      number == 1 -> """
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
      """
      true -> """
#{number - 1} bottles of beer on the wall, #{number - 1} bottles of beer.
Take one down and pass it around, #{number - 2} bottles of beer on the wall.
      """
    end
  end

  @spec lyrics(Range.t) :: String.t
  def lyrics() do
    do_job(100, 1, "")
  end

  def lyrics(first..last) do
    do_job(first, last, "")
  end

  defp do_job(cur, tar, song) do
    cond do
      cur < tar -> song
      cur == 1 -> do_job(cur - 1, tar, song <> verse(cur))
      true -> do_job(cur - 1, tar, song <> verse(cur) <> "\n")
    end
  end
end
