class DeliveryCalculator
  def initialize(rules = default_rules)
    @rules = rules.freeze
  end

  def calculate(subtotal)
    applicable_rule = @rules.find { |rule| subtotal >= rule[:min] }
    applicable_rule ? applicable_rule[:charge] : @rules.last[:charge]
  end

  private

  def default_rules
    [
      { min: 90.0, charge: 0.0 },
      { min: 50.0, charge: 2.95 },
      { min: 0.0, charge: 4.95 }
    ]
  end
end
