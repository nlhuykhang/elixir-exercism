defmodule RobotSimulator do
  @valid_direction_map %{
    :north => :north,
    :east => :east,
    :south => :south,
    :west => :west,
    nil => :north,
  }
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ nil, position \\ nil) do
    cond do
      @valid_direction_map[direction] == nil -> { :error, "invalid direction" }
      is_position_invalid(position) -> { :error, "invalid position" }
      true -> {
        direction || :north,
        position || { 0, 0 }
      }
    end

  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    cond do
      is_instruction_invalid(instructions) -> { :error, "invalid instruction" }
      true -> instructions |> String.codepoints |> move(robot)
    end

  end

  defp is_instruction_invalid(instruction), do: Regex.match?(~r/[^RLA]/, instruction)

  defp move([], robot), do: robot
  defp move(["A" | t], robot), do: move(t, advance_robot(robot))
  defp move([h | t], robot), do: move(t, turn_robot(h, robot))

  defp advance_robot({:north, {x, y}}), do: {:north, {x, y + 1}}
  defp advance_robot({:east, {x, y}}), do: {:east, {x + 1, y}}
  defp advance_robot({:south, {x, y}}), do: {:south, {x, y - 1}}
  defp advance_robot({:west, {x, y}}), do: {:west, {x - 1, y}}

  defp turn_robot("L", {:north, p}), do: {:west, p}
  defp turn_robot("L", {:west, p}), do: {:south, p}
  defp turn_robot("L", {:south, p}), do: {:east, p}
  defp turn_robot("L", {:east, p}), do: {:north, p}

  defp turn_robot("R", {:north, p}), do: {:east, p}
  defp turn_robot("R", {:west, p}), do: {:north, p}
  defp turn_robot("R", {:south, p}), do: {:west, p}
  defp turn_robot("R", {:east, p}), do: {:south, p}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({d, _}), do: d

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position({_, p}), do: p

  defp is_position_invalid(p) do
    cond do
      p == nil -> false
      is_tuple(p) -> is_position_tuple_invalid(p)
      true -> true
    end
  end

  defp is_position_tuple_invalid(p) when tuple_size(p) != 2, do: true
  defp is_position_tuple_invalid({x, y}), do: !is_number(x) || !is_number(y)
end
