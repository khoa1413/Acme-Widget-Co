# Acme Widget Co - Basket System
require_relative 'product_catalog'

class Basket
  def initialize(catalog = ProductCatalog.new)
    @catalog = catalog
    @items = []
  end

  def add(product_code)
    raise ArgumentError, "Unknown product code: #{product_code}" unless @catalog.has_product?(product_code)

    @items << product_code
  end

  def items
    @items.dup
  end

  def total
    @items.sum { |product_code| @catalog.price_for(product_code) }
  end
end
