class EmailNotifier
  def initialize(email:)
    @email = email
  end

  def send_update(shipment, event)
    ts = event.timestamp.strftime("%Y-%m-%d %H:%M:%S")
    puts <<~EMAIL
      [Email to #{@email}]:
      Subject: Shipment Update - #{shipment.tracking_number}

      Your package has been updated:
      Status: #{event.status}
      Location: #{event.location}
      Time: #{ts}

      Track your package at: example.com/track/#{shipment.tracking_number}
      ---
    EMAIL
  end
end