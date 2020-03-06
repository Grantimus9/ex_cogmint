use Mix.Config

config :ex_cogmint,
  cogmint_api_key: System.get_env("COGMINT_API_KEY") || "test-elixir-sdk-key123456",
  callback_url: System.get_env("CALLBACK_URL") || "http://locahost:4000"
