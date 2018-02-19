require_relative 'shipment_config'

# Builds array from hash, which will be outputted to the console
class Printable < ShipmentConfig
  def initialize(transactions)
    @transactions = transactions
    @discounts_array = []
  end

  def build_data
    iterate_transactions
    @discounts_array
  end

  private

  def iterate_transactions
    @transactions.each do |month, transaction|
      add_as_ignored(transaction) if month == :ignored
      add_monthly_discount(transaction) unless month == :ignored
    end
  end

  def add_as_ignored(transaction)
    transaction.each do |t|
      @discounts_array[t[:index]] = t[:arrayed].join(' ') + ' Ignored'
    end
  end

  def add_monthly_discount(monthly)
    monthly.each_value do |items|
      items.each do |item|
        add_to_discounts(item)
      end
    end
  end

  def add_to_discounts(item)
    line = [
      item[:date],
      item[:size],
      item[:provider],
      get_price(item),
      get_discount(item)
    ]

    @discounts_array[item[:index]] = line.join(' ')
  end

  def get_price(item)
    price = ShipmentConfig.const_get("C_#{item[:provider]}_#{item[:size]}")
    price -= item[:discount] if item[:discount]
    format('%.2f', price)
  end

  def get_discount(item)
    discount = format('%.2f', item[:discount]) if item[:discount]
    discount || '-'
  end
end
