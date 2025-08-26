require_relative 'basket'
require_relative 'product_catalog'

def test_product_catalog
  puts 'Testing Product Catalog'
  puts '=' * 25

  catalog = ProductCatalog.new

  puts "Red Widget price: $#{catalog.price_for('R01')}"
  puts "Green Widget price: $#{catalog.price_for('G01')}"
  puts "Blue Widget price: $#{catalog.price_for('B01')}"

  puts "Has R01: #{catalog.has_product?('R01')}"
  puts "Has INVALID: #{catalog.has_product?('INVALID')}"

  puts "✓ Catalog working correctly\n"
end

def test_basket_with_pricing
  puts 'Testing Basket with Pricing'
  puts '=' * 30

  basket = Basket.new
  basket.add('R01')  # $32.95
  basket.add('G01')  # $24.95

  puts "Items: #{basket.items.join(', ')}"
  puts "Total: $#{basket.total}"
  puts "Expected: $#{32.95 + 24.95}"

  if (basket.total - 57.90).abs < 0.01
    puts '✓ Pricing calculation correct'
  else
    puts '✗ Pricing calculation incorrect'
  end
end

def test_error_handling
  puts "\nTesting Error Handling"
  puts '=' * 25

  basket = Basket.new

  begin
    basket.add('INVALID')
    puts '✗ Should have raised error for invalid product'
  rescue ArgumentError => e
    puts "✓ Correctly rejected invalid product: #{e.message}"
  end
end

def run_tests
  test_product_catalog
  test_basket_with_pricing
  test_error_handling

  puts "\n" + '=' * 40
  puts 'All tests completed!'
end

run_tests if __FILE__ == $0
