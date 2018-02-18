require_relative 'shipment_config'

class Printable < ShipmentConfig

  def initialize(transactions)
    @transactions = transactions
    @discounts_array = []
  end

  def get_data
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
    monthly.each do |size, shipments|
      shipments.each do |shipment|
        add_to_discounts(shipment)
      end    
    end    
  end

  def add_to_discounts(shipment)
    line = [ 
      shipment[:date], 
      shipment[:size], 
      shipment[:provider], 
      get_price(shipment), 
      get_discount(shipment) 
    ]

    @discounts_array[shipment[:index]] = line.join(' ')
  end

  def get_price(shipment)
    price = ShipmentConfig.const_get("C_#{shipment[:provider]}_#{shipment[:size]}")
    price -= shipment[:discount] if shipment[:discount]
    '%.2f' % price
  end

  def get_discount(shipment)
    discount = '%.2f' % shipment[:discount] if shipment[:discount]
    discount || '-'
  end
end