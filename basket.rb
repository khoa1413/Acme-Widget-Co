# Acme Widget Co - Basket System
require_relative 'product_catalog'
require_relative 'delivery_calculator'

class Basket
  def initialize(catalog = ProductCatalog.new, delivery_calculator = DeliveryCalculator.new)
    @catalog = catalog
    @delivery_calculator = delivery_calculator
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
    @items.sum { |product_code| @catalog.price_for(product_code) }
  end

  def delivery_charge
    @delivery_calculator.calculate(subtotal)
  end

  def total
    subtotal + delivery_charge
  end
end
