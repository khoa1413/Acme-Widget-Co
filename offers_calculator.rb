class OffersCalculator
  def initialize(offers = default_offers)
    @offers = offers
  end

  def calculate_discounted_subtotal(items, catalog)
    item_counts = items.each_with_object(Hash.new(0)) { |item, counts| counts[item] += 1 }

    subtotal = 0.0
    item_counts.each do |product_code, count|
      base_price = catalog.price_for(product_code)

      subtotal += if @offers.key?(product_code)
                    @offers[product_code].call(base_price, count)
                  else
                    base_price * count
                  end
    end

    subtotal
  end

  private

  def default_offers
    {
      'R01' => lambda do |price, count|
        full_price_items = (count + 1) / 2
        half_price_items = count / 2
        (full_price_items * price) + (half_price_items * price * 0.5)
      end
    }
  end
end
