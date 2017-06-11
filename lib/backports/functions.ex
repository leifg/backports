defmodule Backports.Functions do
  alias Backports.Constants

  # Otherwise we'll get a race condition with compilation in older versions
  Code.ensure_compiled(Backports.PreCompiler)

  defmodule String do
    @before_compile {Backports.PreCompiler, :before_compile}
  end

  def backport?(aliases, function_name) do
    Constants.functions_to_backport |> Enum.member?({aliases, function_name})
  end

  def get(aliases, function_name) do
    if backport?(aliases, function_name) do
      {[:Backports, :Functions | aliases], function_name}
    else
      nil
    end
  end
end
