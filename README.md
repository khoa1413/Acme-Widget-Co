# Acme Widget Co - Basket System

A Ruby implementation of a shopping basket system for Acme Widget Co.

## Overview

This shopping basket calculates order totals with a clean, extensible architecture following SOLID principles.

## Architecture

### ProductCatalog
- **Responsibility**: Manages product data and pricing
- **Interface**: `price_for(code)`, `has_product?(code)`, `product_codes`

### DeliveryCalculator
- **Responsibility**: Calculates delivery charges based on subtotal
- **Interface**: `calculate(subtotal)`
- **Rules**: Configurable delivery charge rules

### Basket
- **Responsibility**: Manages shopping cart items and total calculation
- **Dependencies**: Injected ProductCatalog and DeliveryCalculator

## Products

| Product Code | Product Name | Price |
|--------------|--------------|-------|
| R01          | Red Widget   | $32.95|
| G01          | Green Widget | $24.95|
| B01          | Blue Widget  | $7.95 |

## Delivery Rules

| Order Subtotal | Delivery Charge |
|----------------|-----------------|
| Under $50      | $4.95          |
| $50 - $89.99   | $2.95          |
| $90+           | Free           |

## Current Features

✅ Product catalog with pricing
✅ Basic basket functionality
✅ Input validation
✅ Delivery charge calculation
🚧 Special offers (coming next)

## Usage

```ruby
require_relative 'basket'

basket = Basket.new
basket.add('R01')
basket.add('G01')

puts "Subtotal: $#{basket.subtotal}"
puts "Delivery: $#{basket.delivery_charge}"
puts "Total: $#{basket.total}"
```

## Testing

```bash
ruby test_basket.rb
```

## Development Status

**Current Commit**: Add delivery charge calculation
**Next Commit**: Add special offers system
