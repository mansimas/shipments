require_relative 'app/shipment'

task :run do
  ARGV.each { |a| task a.to_sym do ; end }

  ARGV.drop(1).each do |file_path|
    Shipment.new(file_path).discount
  end
end

task :test do
  exec 'ruby tests/run_test.rb'
end
