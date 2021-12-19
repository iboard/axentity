# Altex - Entity

[![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](http://hexdocs.pm/axentity/)
[![Elixir CI](https://github.com/iboard/axentity/actions/workflows/elixir.yml/badge.svg)](https://github.com/iboard/axentity/actions/workflows/elixir.yml)

## Altex

is a bunch of mix projects, collaborating to support you for a clean
architectural and well crafted system. Yes, think about an Umbrella project
but just without the umbrella, thus the several projects can be developed
completely independent from each other.

## Entity

A wrapper around any kind of data to be used in a repository. `Entity` also
keeps track of errors and validation (a bit like Ecto's Changeset).


## Installation

[Available in Hex](https://hex.pm/packages/axentity), the package can be installed
by adding `axentity` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:axentity, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/axentity](https://hexdocs.pm/axentity).


For now, please see the tests to get a glue what this app is doing.


