defmodule ContactUsWeb.ClientLive.Index do
  use Phoenix.LiveView

  alias ContactUsWeb.Router.Helpers, as: Routes
  alias ContactUsWeb.ClientView
  alias ContactUs.Accounts
  alias ContactUs.Accounts.Client

  def mount(_session, socket) do
    IO.inspect(connected?(socket), label: "CONNTECTION STATUS")
    value = %{
      changeset: Accounts.change_client(%Client{}),
      form_data: %{
        "first_name" => "",
        "last_name" => "",
        "email_address" => "",
        "phone_number" => "",
        "company" => "",
        "service" => "",
      }
    }
    {:ok, assign(socket, value)}
  end

  def render(assigns) do
    ClientView.render("form.html", assigns)
  end

  def handle_event("validate", %{"client" => params} = args, socket) do
    target = args["_target"] |> List.last()
    form_data = socket.assigns.form_data |> Map.put(target, params[target])

    form_data
      |> Accounts.validate_form_input()
      |> case do
        {:ok, %Ecto.Changeset{} = changeset} ->
          value = %{changeset: changeset, form_data: form_data}
                  |> IO.inspect(label: "RESULTS")

          {:noreply, assign(socket, value)}

        {:error, %Ecto.Changeset{} = changeset} ->
          value = %{changeset: changeset, form_data: form_data}
                  |> IO.inspect(label: "RESULTS")

          {:noreply, assign(socket, value)}
      end
  end

  def handle_event("save", %{"client" => params} = args, socket) do
    IO.inspect(args, label: "SAVED DATA")

    params
    |> Accounts.create_client()
    |> case do
        {:ok, _user} ->
          {:stop,
          socket
          |> put_flash(:info, "Client created")
          |> redirect(to: Routes.client_path(ContactUsWeb.Endpoint, :index))}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
