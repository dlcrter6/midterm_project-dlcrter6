module Packages
  class Package
    attr_reader :weight, :origin, :destination, :sender, :recipient

    def initialize(weight:, origin:, destination:, sender:, recipient:)
      @weight, @origin, @destination, @sender, @recipient =
        weight.to_f, origin, destination, sender, recipient
      raise ArgumentError, "weight must be > 0" unless @weight.positive?
    end

    def cost
      raise NotImplementedError, "Subclasses must implement #cost"
    end

    def description
      "#{format('%.2f', weight)}kg from #{origin} to #{destination} (#{sender} → #{recipient})"
    end
  end
end