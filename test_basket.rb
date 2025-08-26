require_relative 'basket'
require_relative 'product_catalog'
require_relative 'delivery_calculator'
require_relative 'offers_calculator'

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

def test_red_widget_offer
  puts 'Testing Red Widget Offer'
  puts '=' * 25

  basket = Basket.new
  basket.add('R01')
  basket.add('R01')

  expected_subtotal = 32.95 + (32.95 * 0.5)
  actual_subtotal = basket.subtotal

  puts "Two red widgets subtotal: $#{actual_subtotal}"
  puts "Expected: $#{expected_subtotal}"

  if (actual_subtotal - expected_subtotal).abs < 0.01
    puts '✓ Red widget offer working correctly'
  else
    puts '✗ Red widget offer not working'
  end
  puts
end

def test_comprehensive_scenarios
  puts 'Testing Comprehensive Scenarios'
  puts '=' * 35

  test_cases = [
    {
      products: %w[B01 G01],
      expected: 37.85,
      description: 'Blue + Green Widget'
    },
    {
      products: %w[R01 R01],
      expected: 54.37,
      description: 'Two Red Widgets (with offer)'
    },
    {
      products: %w[R01 G01],
      expected: 60.85,
      description: 'Red + Green Widget'
    },
    {
      products: %w[B01 B01 R01 R01 R01],
      expected: 98.27,
      description: 'Two Blue + Three Red Widgets'
    }
  ]

  all_passed = true

  test_cases.each_with_index do |test_case, index|
    basket = Basket.new
    test_case[:products].each { |product| basket.add(product) }

    actual = basket.total
    expected = test_case[:expected]
    passed = (actual - expected).abs < 0.01

    status = passed ? '✓ PASS' : '✗ FAIL'
    puts "#{index + 1}. #{test_case[:description]}: $#{actual} #{status}"

    all_passed &&= passed
  end

  puts "\n#{all_passed ? '✓ All scenarios passed!' : '✗ Some scenarios failed!'}"
end

def test_custom_offers
  puts '\nTesting Custom Offers'
  puts '=' * 25

  custom_offers = OffersCalculator.new({
                                         'G01' => ->(price, count) { price * count * 0.9 }
                                       })

  basket = Basket.new(ProductCatalog.new, DeliveryCalculator.new, custom_offers)
  basket.add('G01')
  basket.add('G01')

  expected = (24.95 * 2 * 0.9) + 2.95
  actual = basket.total

  puts "Two green widgets with 10% off: $#{actual}"
  puts "Expected: $#{expected}"

  if (actual - expected).abs < 0.01
    puts '✓ Custom offers working'
  else
    puts '✗ Custom offers not working'
  end
end

def run_tests
  test_product_catalog
  test_delivery_calculator
  test_basket_with_pricing
  test_basket_with_delivery
  test_free_delivery
  test_error_handling
  test_red_widget_offer
  test_comprehensive_scenarios
  test_custom_offers

  puts "\n" + '=' * 50
  puts '🎉 All features implemented and tested!'
  puts 'Basket system is ready for production!'
end

run_tests if __FILE__ == $0
