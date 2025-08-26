# Acme Widget Co - Product Catalog
# Handles product data and pricing logic

class ProductCatalog
  def initialize(products = default_products)
    @products = products.freeze
  end

  def price_for(product_code)
    price = @products[product_code]
    raise ArgumentError, "Unknown product code: #{product_code}" if price.nil?

    price
  end

  def has_product?(product_code)
    @products.key?(product_code)
  end

  def product_codes
    @products.keys
  end

  private

  def default_products
    {
      'R01' => 32.95,  # Red Widget
      'G01' => 24.95,  # Green Widget
      'B01' => 7.95    # Blue Widget
    }
  end
end
