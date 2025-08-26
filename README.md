# Acme Widget Co - Basket System

A Ruby implementation of a shopping basket system for Acme Widget Co.

## Overview

This is a proof-of-concept shopping basket that will calculate order totals including product prices, special offers, and delivery charges.

## Current Status

🚧 **In Development** - Basic basket structure implemented

## Usage

```ruby
require_relative 'basket'

# Create a new basket
basket = Basket.new

# Add items
basket.add('R01')
basket.add('G01')

# View items
puts basket.items

# Get total (not yet implemented)
puts basket.total
```

## Development

This project is being developed incrementally with meaningful commits for each feature.

## Ruby Version

Requires Ruby 2.7+
