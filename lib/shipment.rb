require_relative "tracking_event"

class Shipment
  attr_reader :tracking_number

  def initialize(package:, notifier:)
    @package  = package            # duck-typed to Packages::Package
    @notifier = notifier           # duck-typed, responds to #send_update(shipment, event)
    @events   = []
    @tracking_number = generate_tracking_number
  end

  def update_status(status:, location:, timestamp: Time.now, notes: nil)
    event = TrackingEvent.new(status:, location:, timestamp:, notes:)
    @events << event
    notify(event)
    event
  end

  def current_status
    @events.empty? ? "not_yet_shipped" : @events.last.status
  end

  def events
    @events.dup
  end

  def estimated_cost
    @package.cost
  end

  private

  def generate_tracking_number
    "TRK#{Time.now.to_i}#{rand(1000..9999)}"
  end

  def notify(event)
    return unless @notifier&.respond_to?(:send_update)
    @notifier.send_update(self, event)
  end
end