defmodule ContactUsWeb.ClientController do
  use ContactUsWeb, :controller

  alias ContactUs.Accounts
  alias ContactUs.Accounts.Client
  alias Phoenix.LiveView

  def index(conn, _params) do
    clients = Accounts.list_clients()
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    LiveView.Controller.live_render(conn, ContactUsWeb.ClientLive.Index, session: %{})
    # render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    client = Accounts.get_client!(id)
    render(conn, "show.html", client: client)
  end

  def edit(conn, %{"id" => id}) do
    client = Accounts.get_client!(id)
    changeset = Accounts.change_client(client)
    render(conn, "edit.html", client: client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Accounts.get_client!(id)

    case Accounts.update_client(client, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: Routes.client_path(conn, :show, client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Accounts.get_client!(id)
    {:ok, _client} = Accounts.delete_client(client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: Routes.client_path(conn, :index))
  end
end