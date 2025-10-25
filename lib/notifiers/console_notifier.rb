class ConsoleNotifier
  def send_update(shipment, event)
    ts = event.timestamp.strftime("%Y-%m-%d %H:%M:%S")
    puts "📦 [#{ts}] Shipment #{shipment.tracking_number}: #{event.status} at #{event.location}"
  end
end