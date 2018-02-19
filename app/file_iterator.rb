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
    arrayed = line_as_array(line)
    return set_line(arrayed, index) if valid_line(arrayed)
    @transactions[:ignored].push(arrayed: arrayed, index: index)
  end

  def set_line(arrayed, index)
    month = month_appointment(arrayed)
    objected = line_as_object(arrayed, index, month)
    unless @transactions[month][objected[:size]]
      @transactions[month][objected[:size]] = []
    end
    @transactions[month][objected[:size]].push(objected)
  end

  def month_appointment(arrayed)
    month_name = arrayed[0].split(DATE_DELIMITER).first(2).join('-')
    @transactions[month_name] = {} unless @transactions[month_name]
    month_name
  end

  def line_as_array(line)
    line.strip.split(' ')
  end

  def line_as_object(line, index, month)
    {
      date: line[0],
      size: line[1],
      provider: line[2],
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
  def right_date_length(date_arr)
    return false unless date_arr[0].length == 4
    return false unless date_arr[1].length == 2
    return false unless date_arr[2].length == 2
    true
  end

  # date outside of range of 1900 and 2100 would be not logical
  def right_date_scope(date_arr)
    return false if date_arr[0].to_i < 1900 || date_arr[0].to_i > 2100
    return false if date_arr[1].to_i > 12
    return false if date_arr[2].to_i > 31
    true
  end
end
