defmodule Backports.Lookup do
  alias Backports.Constants
  alias Backports.Functions
  @before_compile {Functions, :before_compile}

  def get(aliases, function_name) do
    internal_lookup = Constants.elixir_version() |> lookup()
    internal_lookup[{aliases, function_name}]
  end

  defp lookup({1, 1, _}) do
    %{
      {[:String], :trim} => {[:Backports, :Lookup], :trim}
    }
  end

  defp lookup({1, 2, _}) do
    %{
      {[:String], :trim} => {[:Backports, :Lookup], :trim}
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
end
