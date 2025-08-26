# Acme Widget Co - Basket System

A Ruby implementation of a shopping basket system for Acme Widget Co.

## Overview

This shopping basket calculates order totals with a clean, extensible architecture following SOLID principles.

## Architecture

### ProductCatalog
- **Responsibility**: Manages product data and pricing
- **Interface**: `price_for(code)`, `has_product?(code)`, `product_codes`
- **Extensible**: Easy to swap with different catalog implementations

### Basket
- **Responsibility**: Manages shopping cart items and total calculation
- **Dependencies**: Injected ProductCatalog for pricing
- **Validation**: Rejects unknown product codes

## Products

| Product Code | Product Name | Price |
|--------------|--------------|-------|
| R01          | Red Widget   | $32.95|
| G01          | Green Widget | $24.95|
| B01          | Blue Widget  | $7.95 |

## Current Features

✅ Product catalog with pricing
✅ Basic basket functionality
✅ Input validation
🚧 Delivery charges (coming next)
🚧 Special offers (planned)

## Usage

```ruby
require_relative 'basket'

# Use default catalog
basket = Basket.new
basket.add('R01')
basket.add('G01')
puts basket.total  # $57.90

# Use custom catalog
custom_catalog = ProductCatalog.new({
  'CUSTOM1' => 10.00,
  'CUSTOM2' => 15.00
})
basket = Basket.new(custom_catalog)
```

## Testing

```bash
ruby test_basket.rb
```

## Development Status

**Current Commit**: Add product catalog with dependency injection
**Next Commit**: Add delivery charge calculation
