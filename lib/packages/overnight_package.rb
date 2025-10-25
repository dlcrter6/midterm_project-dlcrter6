require_relative "package"

module Packages
  class OvernightPackage < Package
    BASE_RATE    = 5.00
    RATE_PER_KG  = 2.50
    OVERNIGHT_FEE = 20.00

    def cost
      BASE_RATE + (weight * RATE_PER_KG) + OVERNIGHT_FEE
    end

    def description
      "OvernightPackage: " + super
    end
  end
end