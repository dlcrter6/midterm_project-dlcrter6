require_relative "package"

module Packages
  class StandardPackage < Package
    BASE_RATE   = 5.00
    RATE_PER_KG = 2.50

    def cost
      BASE_RATE + (weight * RATE_PER_KG)
    end

    def description
      "StandardPackage: " + super
    end
  end
end