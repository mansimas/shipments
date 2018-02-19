require_relative 'shipment_config'

# calculates discounts
class Discounter < ShipmentConfig
  def initialize(transactions)
    @transactions = transactions
    set_discounts
  end

  def build_discounts
    check_free_shipment_discounts
    check_lowest_package_discounts

    @transactions
  end

  private

  # creates object with key-value for every month,
  # where key is month, and value is discount
  def set_discounts
    keys = @transactions.keys - [:ignored]
    @discounts = Hash[keys.product([MAX_MONTHLY_DISCOUNT])]
  end

  def check_free_shipment_discounts
    @transactions.each do |month, sizes|
      next if month == :ignored
      check_free_shipment_discount(sizes) if sizes[FREE_SHIPMENT_ON]
    end
  end

  # only once a shipment can get full discount
  def check_free_shipment_discount(sizes)
    free_order = false
    found_shipments = 0

    sizes[FREE_SHIPMENT_ON].each do |order|
      found_shipments += 1 if order[:provider] == FREE_SHIPMENT_PROVIDER
      if found_shipments == FREE_SHIPMENT_AFTER_ODERS
        free_order = order
        break
      end
    end

    apply_discount(free_order, shipment_provider_price) if free_order
  end

  def check_lowest_package_discounts
    @transactions.each do |month, sizes|
      next if month == :ignored
      next if @discounts[month] <= 0
      check_lowest_package_discount(sizes) if sizes[LOWEST_PRICE_ON]
    end
  end

  def check_lowest_package_discount(sizes)
    sizes[LOWEST_PRICE_ON].each do |order|
      break if @discounts[order[:month]] <= 0
      add_lowest_package_discount(order)
    end
  end

  def add_lowest_package_discount(order)
    discount = lowest_prices[order[:provider].to_sym] - lowest_prices.values.min
    apply_discount(order, discount) if discount > 0
  end

  def apply_discount(order, discount)
    remaining_discount = @discounts[order[:month]]
    applied_discount = [discount, remaining_discount].min
    @discounts[order[:month]] = (remaining_discount - applied_discount).round(2)
    order[:discount] = applied_discount if applied_discount > 0
  end

  def lowest_prices
    lp_const = ShipmentConfig.const_get("C_#{LA_POSTE}_#{LOWEST_PRICE_ON}")
    mr_const = ShipmentConfig.const_get("C_#{MONDIAL_RELAY}_#{LOWEST_PRICE_ON}")
    {
      LA_POSTE.to_sym => lp_const,
      MONDIAL_RELAY.to_sym => mr_const
    }
  end

  def shipment_provider_price
    ShipmentConfig.const_get("C_#{FREE_SHIPMENT_PROVIDER}_#{FREE_SHIPMENT_ON}")
  end
end
