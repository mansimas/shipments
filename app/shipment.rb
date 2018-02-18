Dir[File.join(__dir__, '*.rb')].each { |file| require file }

class Shipment < ShipmentConfig

  def initialize(file_path)
    set_file_path(file_path)
  end

  def discount
    return false unless @file_path
    transactions = FileIterator.new(@file_path).build_transactions
    transactions = Discounter.new(transactions).build_discounts
    @discounts_array = Printable.new(transactions).get_data
    print_to_STDOUT
  end

  private

  def print_to_STDOUT
    @discounts_array.each do |line|
      puts line
    end
  end

  def set_file_path(file_path)
    return @file_path = file_path if File.file?(file_path)
    return @file_path = "../#{file_path}" if File.file?("../#{file_path}")
    puts "File not found: #{file_path}"
  end
end