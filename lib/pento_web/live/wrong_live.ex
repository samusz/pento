defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  alias Pento.Accounts

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session)
    {:ok, assign(socket, score: 0, message: "Make a guess:", session_id: session["user_token"])}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
       	It's <%= time() %>

    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {:noreply,
     assign(
       socket,
       message: message,
       score: score
     )}
  end

  def time() do
    DateTime.utc_now()
    |> to_string
  end

  # TODO the socket when the game is created, one the user will need to guess.
  # TODO Check for that number in the handle_event for guess.
  # TODO Show a winning message when the user guesses the right number and increment their score in the socket assigns.
  # TODO Show a restart message and button when the user wins. Hint: you might want to check out the live_patch/2[14] function to help you build that button. You can treat this last challenge as a stretch goal. We’ll get into live_patch/2 in greater detail in upcoming chapters.
end
