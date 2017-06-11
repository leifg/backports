defmodule Backports.Functions do
  alias Backports.Constants

  defmodule String do
    @before_compile {Backports.PreCompiler, :before_compile}
  end

  def change?(aliases, function_name) do
    Constants.functions_to_backport |> Enum.member?({aliases, function_name})
  end

  def get(aliases, function_name) do
    if change?(aliases, function_name) do
      {[:Backports, :Functions | aliases], function_name}
    else
      nil
    end
  end
end
