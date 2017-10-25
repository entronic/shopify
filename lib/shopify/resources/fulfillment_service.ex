defmodule Shopify.FulfillmentService do
  @derive [Poison.Encoder]
  @singular "fulfillment_service"
  @plural "fulfillment_services"

  use Shopify.Resource, import: [
    :find,
    :all,
    :create,
    :update,
    :delete
  ]

  alias Shopify.FulfillmentService

  defstruct [
    :callback_url,
    :format,
    :handle,
    :inventory_management,
    :name,
    :provider_id,
    :requires_shipping_method,
    :tracking_support
  ]

  @doc false
  def empty_resource do
    %FulfillmentService{}
  end

  @doc false
  def find_url(id), do: @plural <>  "/#{id}.json"

  @doc false
  def all_url, do: @plural <> ".json"

end