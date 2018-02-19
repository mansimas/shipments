require_relative 'shipment_config'

# Builds array from hash. Array will be returned and outputted to the console
class Printable < ShipmentConfig
  def initialize(transactions)
    @transactions = transactions
    @discounts = []
  end

  def build_data
    iterate_transactions
    @discounts
  end

  private

  def iterate_transactions
    @transactions.each do |month, sizes|
      add_as_ignored(sizes) if month == :ignored
      add_monthly_discount(sizes) unless month == :ignored
    end
  end

  def add_as_ignored(sizes)
    sizes.each do |order|
      @discounts[order[:index]] = order[:arrayed].join(' ') + ' Ignored'
    end
  end

  def add_monthly_discount(sizes)
    sizes.each_value do |orders|
      orders.each do |order|
        add_to_discounts(order)
      end
    end
  end

  def add_to_discounts(order)
    line = [
      order[:date],
      order[:size],
      order[:provider],
      get_price(order),
      get_discount(order)
    ]

    @discounts[order[:index]] = line.join(' ')
  end

  def get_price(order)
    price = ShipmentConfig.const_get("C_#{order[:provider]}_#{order[:size]}")
    price -= order[:discount] if order[:discount]
    format('%.2f', price)
  end

  def get_discount(order)
    discount = format('%.2f', order[:discount]) if order[:discount]
    discount || '-'
  end
end
