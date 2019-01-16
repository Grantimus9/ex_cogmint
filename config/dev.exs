use Mix.Config

config :ex_cogmint,
  cogmint_api_key: System.get_env("COGMINT_API_KEY"),
  callback_url: System.get_env("CALLBACK_URL"),
  cogmint_url: System.get_env("COGMINT_URL") || "http://localhost:4001"
