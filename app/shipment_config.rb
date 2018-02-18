class ShipmentConfig
  LA_POSTE = 'LP'
  MONDIAL_RELAY = 'MR'
  S_SIZE = 'S'
  M_SIZE = 'M'
  L_SIZE = 'L'

  # building constants example: C_LP_S
  # it begins with C, because lower-case letters can't be constants
  const_set("C_#{LA_POSTE}_#{S_SIZE}", 1.5)
  const_set("C_#{LA_POSTE}_#{M_SIZE}", 4.9)
  const_set("C_#{LA_POSTE}_#{L_SIZE}", 6.9)
  const_set("C_#{MONDIAL_RELAY}_#{S_SIZE}", 2)
  const_set("C_#{MONDIAL_RELAY}_#{M_SIZE}", 3)
  const_set("C_#{MONDIAL_RELAY}_#{L_SIZE}", 4)

  AVAILABLE_SHIPMENTS = [LA_POSTE, MONDIAL_RELAY]
  AVAILABLE_SIZES = [S_SIZE, M_SIZE, L_SIZE]

  DATE_DELIMITER = '-'
  MAX_MONTHLY_DISCOUNT = 10.00

  FREE_SHIPMENT_PROVIDER = LA_POSTE
  FREE_SHIPMENT_ON = L_SIZE
  FREE_SHIPMENT_AFTER_ODERS = 3

  LOWEST_PRICE_ON = S_SIZE
end