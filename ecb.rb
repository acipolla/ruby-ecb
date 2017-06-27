require 'open-uri'
require 'nokogiri'
require 'redis'
redis = Redis.new
 doc = Nokogiri::XML(open('https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'))
  doc.remove_namespaces!
  doc.xpath("//Cube/Cube").each do |cube|
    cube.xpath("./Cube").each do |curr|
      currency= curr.xpath('@currency').to_s
      rate = curr.xpath('@rate').to_s
     redis.set(currency,rate)
    end
  end

