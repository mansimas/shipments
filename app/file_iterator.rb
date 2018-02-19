require_relative 'shipment_config'

# Reading from file and building object for faster processing
class FileIterator < ShipmentConfig
  def initialize(file_path)
    @transactions = { ignored: [] }
    @file_path = file_path
  end

  def build_transactions
    File.readlines(@file_path).each_with_index do |line, index|
      add_transaction(line, index)
    end

    @transactions
  end

  private

  def add_transaction(line, index)
    arrayed = line.strip.split(' ')
    return set_line(arrayed, index) if valid_line(arrayed)
    @transactions[:ignored].push(arrayed: arrayed, index: index)
  end

  def set_line(arrayed, index)
    month = current_month(arrayed)
    objected = line_as_object(arrayed, index, month)
    unless @transactions[month][objected[:size]]
      @transactions[month][objected[:size]] = []
    end
    @transactions[month][objected[:size]].push(objected)
  end

  def current_month(arrayed)
    month_name = arrayed[0].split(DATE_DELIMITER).first(2).join('-')
    @transactions[month_name] = {} unless @transactions[month_name]
    month_name
  end

  def line_as_object(arrayed, index, month)
    {
      date: arrayed[0],
      size: arrayed[1],
      provider: arrayed[2],
      index: index,
      month: month
    }
  end

  def valid_line(line)
    return false unless line.length == 3
    return false unless valid_date(line[0])
    return false unless AVAILABLE_SIZES.include? line[1]
    return false unless AVAILABLE_SHIPMENTS.include? line[2]
    true
  end

  def valid_date(date)
    return passing_date(date) if date.split(DATE_DELIMITER).length == 3
    false
  end

  def passing_date(date)
    splitted = date.split(DATE_DELIMITER)
    return false unless right_date_length(splitted)
    return false unless right_date_scope(splitted)
    true
  end

  # checking 2000-02-02 format
  def right_date_length(arr)
    return false unless arr[0].length == 4
    return false unless arr[1].length == 2
    return false unless arr[2].length == 2
    true
  end

  # transaction date outside of range between 2000 and 2100 could never happend
  def right_date_scope(arr)
    return false unless arr[0].to_i.between?(2000, 2100)
    return false unless arr[1].to_i.between?(1, 12)
    return false unless arr[2].to_i.between?(1, 31)
    true
  end
end
