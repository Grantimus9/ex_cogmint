# ExCogmint

Elixir client for Cogmint.com, a site that allows you to easily crowd source small
tasks within your company.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_cogmint` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cogmint, "~> 0.0.1"}
  ]
end
```

In your app's mix.exs file:

```elixir
  config :ex_cogmint,
    cogmint_api_key: "your-api-key-here"
```
or, if running on Heroku or pulling environment variables at runtime:
```elixir
config :ex_cogmint,
  cogmint_api_key: System.get_env("COGMINT_API_KEY")
```

## Examples

Create a template and project using the web interface at cogmint.com. Using your project UUID, you can
add more tasks to a given project. Let's say you have a template and project that takes the variable "new_user_email" and generates a prompt asking the worker-employee to say whether or not the email address is
someone that works at your company, because you don't want to count them in your user counts.

```elixir
  email = NewUserFinder.get_latest_user_email() # a fictional method.
  ExCogmint.add_task!("project-uuid-12345", %{"new_user_email" => email})
```
Now, another task will be available under that project, using the project's template and default parameters,
like how many unique responses per task you want.





Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_cogmint](https://hexdocs.pm/ex_cogmint).
