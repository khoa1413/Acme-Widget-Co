# Acme Widget Co - Basket System
require_relative 'product_catalog'
require_relative 'delivery_calculator'
require_relative 'offers_calculator'

class Basket
  def initialize(catalog = ProductCatalog.new, delivery_calculator = DeliveryCalculator.new,
                 offers_calculator = OffersCalculator.new)
    @catalog = catalog
    @delivery_calculator = delivery_calculator
    @offers_calculator = offers_calculator
    @items = []
  end

  def add(product_code)
    raise ArgumentError, "Unknown product code: #{product_code}" unless @catalog.has_product?(product_code)

    @items << product_code
  end

  def items
    @items.dup
  end

  def subtotal
    @offers_calculator.calculate_discounted_subtotal(@items, @catalog)
  end

  def delivery_charge
    @delivery_calculator.calculate(subtotal)
  end

  def total
    total_cents = ((subtotal + delivery_charge) * 100).floor
    total_cents / 100.0
  end
end
