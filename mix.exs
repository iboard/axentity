defmodule Axentity.MixProject do
  use Mix.Project

  defp description() do
    ~s"""
    A simple wrapper around any data, to be used in `axrepo`.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Andreas Altendorfer"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/iboard/axentity"}
    ]
  end

  def project do
    [
      app: :axentity,
      version: "0.1.0",
      elixir: "~> 1.13.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      xref: [exclude: [:crypto]],
      # Hex
      package: package(),
      description: description(),
      licenses: ["MIT"],
      links: ["https://github.com/iboard/altex"],

      # Docs
      name: "Altex.Repo",
      source_url: "https://github.com/iboard/axentity",
      homepage_url: "https://github.com/iboard/altex",
      docs: [
        # The main page in the docs
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:uuid, "~> 1.1"},
      # for development only
      {:credo, "~> 1.6", runtime: false, only: [:dev]},
      {:dialyxir, "~> 1.1", runtime: false, only: [:dev]},
      {:ex_doc, "~> 0.26", runtime: false, only: [:dev]}
    ]
  end
end
