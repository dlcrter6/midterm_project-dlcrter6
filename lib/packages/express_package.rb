require_relative "package"

module Packages
  class ExpressPackage < Package
    BASE_RATE          = 5.00
    RATE_PER_KG        = 2.50
    EXPRESS_MULTIPLIER = 1.5

    def cost
      (BASE_RATE + (weight * RATE_PER_KG)) * EXPRESS_MULTIPLIER
    end

    def description
      "ExpressPackage: " + super
    end
  end
end