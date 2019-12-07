defmodule ContactUsWeb.ClientLive.Index do
  use Phoenix.LiveView

  alias ContactUsWeb.Router.Helpers, as: Routes
  alias ContactUsWeb.ClientView
  alias ContactUs.Accounts
  alias ContactUs.Accounts.Client

  def mount(_session, socket) do
    changeset = Accounts.change_client(%Client{})
    {:ok, assign(socket, :changeset, changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(ClientView, "form.html", assigns)
  end

  def handle_event("save", args, socket) do
    IO.inspect(args, label: "VALDIATE DATA")

    {:noreply, socket}
  end
end
