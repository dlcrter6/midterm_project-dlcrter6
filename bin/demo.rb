$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))

require "time"
require "packages/standard_package"
require "packages/express_package"
require "packages/overnight_package"
require "notifiers/console_notifier"
require "notifiers/sms_notifier"
require "notifiers/email_notifier"
require "shipment"

puts "=== Package Delivery Tracking System Demo ==="

std = Packages::StandardPackage.new(weight: 2.5, origin: "New York", destination: "Los Angeles", sender: "Dana", recipient: "Riley")
exp = Packages::ExpressPackage.new(weight: 3.0, origin: "Boston", destination: "Miami", sender: "Alice", recipient: "Bob")

puts "\nEstimated shipping costs:"
puts "  Standard: $#{format('%.2f', std.cost)}"
puts "  Express:  $#{format('%.2f', exp.cost)}"

puts "\nCreating shipment with ConsoleNotifier..."
ship1 = Shipment.new(package: std, notifier: ConsoleNotifier.new)
puts "Shipment created: #{ship1.tracking_number}"
ship1.update_status(status: "picked_up", location: "New York",   timestamp: Time.parse("2025-01-15 10:00:00"))
ship1.update_status(status: "in_transit", location: "Chicago",    timestamp: Time.parse("2025-01-15 12:30:00"))
ship1.update_status(status: "delivered",  location: "Los Angeles",timestamp: Time.parse("2025-01-15 14:30:00"))
puts "Current status: #{ship1.current_status}"
puts "Total events: #{ship1.events.size}"

puts "\nCreating shipment with SMSNotifier..."
ship2 = Shipment.new(package: exp, notifier: SMSNotifier.new(phone_number: "+1-555-123-4567"))
puts "Shipment created: #{ship2.tracking_number}"
ship2.update_status(status: "picked_up", location: "Boston", timestamp: Time.parse("2025-01-15 10:15:00"))
ship2.update_status(status: "delivered", location: "Miami",  timestamp: Time.parse("2025-01-15 16:00:00"))

puts "\nDemo complete!"