class TrackingEvent
  attr_reader :status, :location, :timestamp, :notes

  def initialize(status:, location:, timestamp: Time.now, notes: nil)
    @status, @location, @timestamp, @notes = status.to_s, location, timestamp, notes
    freeze
  end

  def to_s
    ts = timestamp.strftime("%Y-%m-%d %H:%M:%S")
    base = "[#{ts}] #{status} at #{location}"
    notes ? "#{base} (#{notes})" : base
  end
end