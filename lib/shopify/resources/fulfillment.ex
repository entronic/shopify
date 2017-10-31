defmodule Shopify.Fulfillment do
  @moduledoc false
  
  @derive [Poison.Encoder]
  @singular "fulfillment"
  @plural "fulfillments"

  use Shopify.Resource, import: []

  alias Shopify.{Fulfillment, LineItem}

  defstruct [
    :created_at,
    :id,
    :line_items,
    :notify_customer,
    :order_id,
    :receipt,
    :status,
    :tracking_company,
    :tracking_number,
    :tracking_numbers,
    :tracking_url,
    :tracking_urls,
    :updated_at,
    :variant_inventory_management
  ]

  @doc false
  def empty_resource do
    %Fulfillment{
      line_items: [%LineItem{}]
    }
  end

  @doc false
  def find(session, order_id, id, params \\ %{}) do
    session
      |> Request.new(find_url(order_id, id), params, singular_resource())
      |> Client.get
  end

  @doc false
  def all(session, order_id, params \\ %{}) do
    session
      |> Request.new(all_url(order_id), params, plural_resource())
      |> Client.get
  end

  @doc false
  def count(session, order_id, params \\ %{}) do
    session
      |> Request.new(count_url(order_id), params, nil)
      |> Client.get
  end

  @doc false
  def create(session, order_id, new_resource) do
    body = new_resource |> to_json
    session
      |> Request.new(all_url(order_id), %{}, singular_resource(), body)
      |> Client.post
  end

  @doc false
  def update(session, order_id, id, updated_resource) do
    body = updated_resource |> to_json
    session
      |> Request.new(find_url(order_id, id), %{}, singular_resource(), body)
      |> Client.put
  end

  @doc false
  def complete(session, order_id, id, params \\ %{}), do: set_status(session, order_id, id, "complete", params)

  @doc false
  def open(session, order_id, id, params \\ %{}), do: set_status(session, order_id, id, "open", params)

  @doc false
  def cancel(session, order_id, id, params \\ %{}), do: set_status(session, order_id, id, "cancel", params)

  @doc false
  def set_status(session, order_id, id, new_status, params \\ %{}) do
    session
      |> Request.new(set_status_url(order_id, id, new_status), params, singular_resource(), "{}")
      |> Client.post
  end

  @doc false
  def find_url(order_id, id), do: "orders/#{order_id}/#{@plural}/#{id}.json"

  @doc false
  def all_url(order_id), do: "orders/#{order_id}/#{@plural}.json"

  @doc false
  def count_url(order_id), do: "orders/#{order_id}/#{@plural}/count.json"

  @doc false
  def set_status_url(order_id, id, status), do: "orders/#{order_id}/#{@plural}/#{id}/#{status}.json"

end