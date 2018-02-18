require_relative 'shipment_config'

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

  # creates object with key-value for every month, where key is month, and value is discount
  def set_discounts
    keys = @transactions.keys - [:ignored]
    @discounts = Hash[keys.product([MAX_MONTHLY_DISCOUNT])]
  end

  def check_free_shipment_discounts
    @transactions.each do |key, transaction|
      next if key == :ignored
      check_free_shipment_discount(transaction) if transaction[FREE_SHIPMENT_ON]
    end
  end

  # only once a shipment can get full discount
  def check_free_shipment_discount(transaction)
    discount = false
    found_shipments = 0

    transaction[FREE_SHIPMENT_ON].each do |t|
      found_shipments += 1 if t[:provider] == FREE_SHIPMENT_PROVIDER
      if found_shipments == FREE_SHIPMENT_AFTER_ODERS
        discount = t
        break
      end
    end

    add_free_shipment_discount(discount) if discount
  end

  def add_free_shipment_discount(t)
    available_discount = @discounts[t[:month]]
    total_discount = [free_shipment_price, available_discount].min
    @discounts[t[:month]] = (available_discount - total_discount).round(2)
    t[:discount] = total_discount if total_discount > 0
  end

  def check_lowest_package_discounts
    @transactions.each do |key, transaction|
      next if key == :ignored
      next if @discounts[key] <= 0
      check_lowest_package_discount(transaction) if transaction[LOWEST_PRICE_ON]
    end    
  end

  def check_lowest_package_discount(transaction)
    transaction[LOWEST_PRICE_ON].each do |t|
      break if @discounts[t[:month]] <= 0
      add_lowest_package_discount(t)
    end
  end

  def add_lowest_package_discount(t)
    discount = current_price(t) - minimum_price
    apply_lowest_package_discount(t, discount) if discount > 0
  end

  def apply_lowest_package_discount(t, discount)
    available_discount = @discounts[t[:month]]
    total_discount = [discount, available_discount].min
    @discounts[t[:month]] = (available_discount - total_discount).round(2)
    t[:discount] = total_discount if total_discount > 0  
  end

  def current_price(t)
    lowest_prices[ t[:provider].to_sym ]
  end

  def minimum_price
    lowest_prices.values.min
  end

  def lowest_prices
    { 
      "#{LA_POSTE}": ShipmentConfig.const_get("C_#{LA_POSTE}_#{LOWEST_PRICE_ON}"), 
      "#{MONDIAL_RELAY}": ShipmentConfig.const_get("C_#{MONDIAL_RELAY}_#{LOWEST_PRICE_ON}") 
    }
  end

  def free_shipment_price
    ShipmentConfig.const_get("C_#{FREE_SHIPMENT_PROVIDER}_#{FREE_SHIPMENT_ON}")
  end
end