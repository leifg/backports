# Backports

Tooling to make it possible to run "new" code in old Elixir versions.

Currently the following functions not available before 1.3 can be backported:
  - `String.trim`
  - `String.to_charlist`
  - `String.pad_leading`
  - `String.pad_trailing`
can replace `trim` and `to_charlist` functions which were not available prior to Elixir 1.3.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `backports` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:backports, "~> 0.2.0"}]
end
```


## Usage

Whatever module uses a function that is not available, just include `Backports`

This code will work in Elixir 1.1 and 1.2
```elixir
defmodule Foo do
  use Backports

  def bar do
    String.trim("  amazing   ")
  end
end
```
