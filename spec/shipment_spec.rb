require "shipment"
require "tracking_event"

class NullNotifier
  attr_reader :calls
  def initialize; @calls = []; end
  def send_update(shipment, event); @calls << [shipment.tracking_number, event.to_s]; end
end

class FakePackage
  def initialize(cost); @cost = cost; end
  def cost; @cost; end
end

RSpec.describe Shipment do
  let(:package)  { FakePackage.new(12.34) }
  let(:notifier) { NullNotifier.new }
  subject(:shipment) { described_class.new(package: package, notifier: notifier) }

  it "generates a tracking number" do
    expect(shipment.tracking_number).to match(/^TRK\d{10,}\d{4}$/)
  end

  it "starts with not_yet_shipped status" do
    expect(shipment.current_status).to eq("not_yet_shipped")
  end

  it "adds events and updates current_status" do
    event = shipment.update_status(status: "picked_up", location: "NYC")
    expect(shipment.events).to include(event)
    expect(shipment.current_status).to eq("picked_up")
  end

  it "notifies via injected notifier" do
    shipment.update_status(status: "picked_up", location: "NYC")
    expect(notifier.calls.length).to eq(1)
    expect(notifier.calls.first.first).to eq(shipment.tracking_number)
  end

  it "returns a defensive copy of events" do
    shipment.update_status(status: "picked_up", location: "NYC")
    copy = shipment.events
    copy.clear
    expect(shipment.events.size).to eq(1)
  end

  it "delegates estimated_cost to package" do
    expect(shipment.estimated_cost).to eq(12.34)
  end

  context "edge cases" do
    it "accepts notes and timestamp" do
      t = Time.at(0)
      event = shipment.update_status(status: "in_transit", location: "Chi", timestamp: t, notes: "hub scan")
      expect(event.to_s).to include("hub scan")
      expect(event.timestamp).to eq(t)
    end

    it "does not crash if notifier lacks send_update" do
      s = described_class.new(package: package, notifier: Object.new)
      expect { s.update_status(status: "x", location: "y") }.not_to raise_error
    end
  end
end