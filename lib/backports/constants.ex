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
end
