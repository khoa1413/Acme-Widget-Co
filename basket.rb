# Acme Widget Co - Basket System
# A simple shopping basket for calculating order totals

class Basket
  # Initialize an empty basket
  def initialize
    @items = []
  end

  # Add a product to the basket
  # @param product_code [String] The product code to add
  def add(product_code)
    @items << product_code
  end

  # Get all items in the basket
  # @return [Array] Copy of items array
  def items
    @items.dup
  end

  # Calculate the total cost of items in the basket
  # @return [Float] Total cost
  def total
    # TODO: Implement pricing logic
    0.0
  end
end
