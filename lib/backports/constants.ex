defmodule Backports.Constants do
  def elixir_version do
    :application.which_applications
      |> Enum.find(fn({app, _name, _version}) -> app == :elixir end)
      |> elem(2)
      |> to_string()
      |> String.split("-")
      |> List.first
      |> String.split(".")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple
  end

  def functions_to_backport do
    case elixir_version() do
      {1, 1, _} -> [{[:String], :trim}, {[:String], :to_charlist}, {[:String], :pad_leading}, {[:String], :pad_trailing}]
      {1, 2, _} -> [{[:String], :trim}, {[:String], :to_charlist}, {[:String], :pad_leading}, {[:String], :pad_trailing}]
      _ -> []
    end
  end
end
