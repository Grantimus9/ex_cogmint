# ExCogmint

Elixir client for Cogmint.com, a site that allows you to easily crowd source small
tasks within your company.

## Installation

The package can be installed by adding `ex_cogmint` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_cogmint, "~> 0.0.6"}
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

[Hex Documentation](https://hexdocs.pm/ex_cogmint/ExCogmint.html)

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

## Setup

1. Create an account at www.cogmint.com
2. Setup your app's webhook URL at www.cogmint.com/account

Cogmint will confirm that you own your webhook URL before sending it any traffic. If you're using Phoenix, here's some sample code:

First, Set a route pointing to the controller that will handle incoming webhooks for Cogmint.
```elixir
# In myapp_web/router.ex
scope "/", MyAppWeb do
  # ...
  post "/incomingwebhooks/cogmint", MyAppCogmintWebhooksController, :receive
  # ...
end
```

Then, to respond to the challenge, you can use this code:
```elixir
  # In myapp_web/controllers/my_app_cogmint_webhooks_controller.ex
  # the function that handles incoming traffic.
  def receive(conn, %{"event" => "challenge", "data" => data}) do
    json(conn, %{token: data["token"]})
  end
```

3. Set the API Keys in your app's mix.config as described above.
4. Start making calls to the API.
