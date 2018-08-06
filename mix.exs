defmodule ScChecksumHelper.MixProject do
  use Mix.Project

  def project do
    [
      app: :sc_checksum_helper,
      description: "This library calculates the checksum for requests to the SafeCharge's payment servers",
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:timex],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev], runtime: false},
      {:timex, "~> 3.3"}
    ]
  end

  defp package do
    [
      maintainers: ["antona@safecharge.com"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => ""
      }
    ]
  end
end
