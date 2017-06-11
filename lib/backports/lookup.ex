defmodule Backports.Lookup do
  def get(aliases, function_name) do
    internal_lookup = elixir_version() |> lookup()
    internal_lookup[{aliases, function_name}]
  end

  defp lookup({1, 1, _}) do
    %{
      {[:String], :trim} => {[:String], :strip}
    }
  end

  defp lookup({1, 2, _}) do
    %{
      {[:String], :trim} => {[:String], :strip}
    }
  end

  defp lookup({1, 3, _}) do
    %{}
  end

  defp lookup({1, 4, _}) do
    %{}
  end

  defp lookup({1, 5, _}) do
    %{}
  end

  defp lookup(version) do
    IO.warn("Unknown version #{inspect version}")
    %{}
  end

  defp elixir_version do
    :application.which_applications
      |> Enum.find(fn({app, _name, _version}) -> app == :elixir end)
      |> elem(2)
      |> to_string()
      |> String.split(".")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple
  end
end
