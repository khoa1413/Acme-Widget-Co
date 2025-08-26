require_relative 'basket'

def test_basket_examples
  puts 'Testing Acme Widget Co Basket Implementation'
  puts '=' * 50

  test_cases = [
    {
      products: %w[B01 G01],
      expected: 37.85,
      description: 'Blue Widget + Green Widget'
    },
    {
      products: %w[R01 R01],
      expected: 54.37,
      description: 'Two Red Widgets (with offer)'
    },
    {
      products: %w[R01 G01],
      expected: 60.85,
      description: 'Red Widget + Green Widget'
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

    test_case[:products].each do |product|
      basket.add(product)
    end

    actual_total = basket.total
    expected_total = test_case[:expected]

    passed = (actual_total - expected_total).abs < 0.01
    all_passed &&= passed

    status = passed ? '✓ PASS' : '✗ FAIL'

    puts "Test #{index + 1}: #{test_case[:description]}"
    puts "  Products: #{test_case[:products].join(', ')}"
    puts "  Expected: $#{expected_total}"
    puts "  Actual:   $#{actual_total}"
    puts "  #{status}"
    puts
  end

  puts '=' * 50
  puts all_passed ? 'All tests PASSED!' : 'Some tests FAILED!'

  all_passed
end

def demonstrate_basket_usage
  puts "\nDemonstrating Basket Usage:"
  puts '-' * 30

  basket = Basket.new

  puts 'Created new basket'
  puts 'Adding R01 (Red Widget)...'
  basket.add('R01')
  puts "Current total: $#{basket.total}"

  puts 'Adding R01 (Red Widget) again...'
  basket.add('R01')
  puts "Current total: $#{basket.total} (note the red widget offer applied)"

  puts 'Adding G01 (Green Widget)...'
  basket.add('G01')
  puts "Final total: $#{basket.total}"

  puts "Items in basket: #{basket.items.join(', ')}"
end

# Run the tests
if __FILE__ == $0
  test_basket_examples
  demonstrate_basket_usage
end
