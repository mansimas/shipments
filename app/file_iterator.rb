require_relative 'shipment_config'

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
    @transactions[:ignored].push({ arrayed: arrayed, index: index })
  end

  def set_line(arrayed, index)
    month = set_and_get_month(arrayed)
    objected = line_as_object(arrayed, index, month)
    @transactions[month][objected[:size]] = [] unless @transactions[month][objected[:size]]
    @transactions[month][objected[:size]].push(objected)
  end

  def set_and_get_month(arrayed)
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
      month: month,
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
    valid = false

    begin
      valid = true if date.split(DATE_DELIMITER).length == 3
    rescue 
      false
    end

    if valid
      splitted = date.split(DATE_DELIMITER)
      valid = false unless splitted[0].length == 4
      valid = false unless splitted[1].length == 2
      valid = false unless splitted[2].length == 2
      valid = false if splitted[0].to_i < 1900 || splitted[0].to_i > 2100
      valid = false if splitted[1].to_i > 12
      valid = false if splitted[2].to_i > 31
    end

    valid
  end
end