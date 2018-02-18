require_relative 'shipment_config'
require_relative 'file_iterator'
require_relative 'discounter'

class Shipment < ShipmentConfig

  def initialize(file_path)
    set_file_path(file_path)
  end

  def discount
    return false unless @file_path
    transactions = FileIterator.new(@file_path).build_transactions
    transactions = Discounter.new(transactions).build_discounts

    puts transactions.inspect
  end

  def set_file_path(file_path)
    return @file_path = file_path if File.file?(file_path)
    return @file_path = "../#{file_path}" if File.file?("../#{file_path}")
    puts "File not found: #{file_path}"
  end
end