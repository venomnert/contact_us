defmodule ContactUs.Accounts.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :company, :string
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :service, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:first_name, :last_name, :email_address, :phone_number, :company, :service])
    |> validate_required([:first_name, :last_name, :email_address, :phone_number, :company, :service])
  end
end
