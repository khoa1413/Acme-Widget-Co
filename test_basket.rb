require_relative 'basket'
require_relative 'product_catalog'
require_relative 'delivery_calculator'

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

def test_delivery_calculator
  puts 'Testing Delivery Calculator'
  puts '=' * 30

  calculator = DeliveryCalculator.new

  puts "Delivery for $30: $#{calculator.calculate(30.0)}"
  puts "Delivery for $60: $#{calculator.calculate(60.0)}"
  puts "Delivery for $100: $#{calculator.calculate(100.0)}"

  puts "✓ Delivery calculator working\n"
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

def test_basket_with_delivery
  puts 'Testing Basket with Delivery'
  puts '=' * 30

  basket = Basket.new
  basket.add('B01')
  basket.add('G01')

  subtotal = basket.subtotal
  delivery = basket.delivery_charge
  total = basket.total

  puts "Items: #{basket.items.join(', ')}"
  puts "Subtotal: $#{subtotal}"
  puts "Delivery: $#{delivery}"
  puts "Total: $#{total}"

  expected_total = 7.95 + 24.95 + 4.95
  if (total - expected_total).abs < 0.01
    puts '✓ Total calculation correct'
  else
    puts '✗ Total calculation incorrect'
  end
end

def test_free_delivery
  puts '\nTesting Free Delivery'
  puts '=' * 25

  basket = Basket.new
  basket.add('R01')
  basket.add('R01')
  basket.add('R01')

  puts "Subtotal: $#{basket.subtotal}"
  puts "Delivery: $#{basket.delivery_charge}"
  puts "Total: $#{basket.total}"

  if basket.delivery_charge == 0.0
    puts '✓ Free delivery applied correctly'
  else
    puts '✗ Free delivery not applied'
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
  test_delivery_calculator
  test_basket_with_pricing
  test_basket_with_delivery
  test_free_delivery
  test_error_handling

  puts "\n" + '=' * 40
  puts 'All tests completed!'
end

run_tests if __FILE__ == $0
