class SMSNotifier
  def initialize(phone_number:)
    @phone_number = phone_number
  end

  def send_update(shipment, event)
    ts = event.timestamp.strftime("%Y-%m-%d %H:%M:%S")
    puts "[SMS to #{@phone_number}]: Your package #{shipment.tracking_number} is now #{event.status} at #{ts}"
  end
end