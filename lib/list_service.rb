class ListService
  require 'json'
  require 'net/http'

  def get_customers(count = {})
    s = Net::HTTP.get_response(URI.parse("http://www.thomas-bayer.com/sqlrest/CUSTOMER/#{count[:id]}")).body
    return JSON.parse(Hash.from_xml(s).to_json)
  end
  
  def get_products(count = {})
    s = Net::HTTP.get_response(URI.parse("http://www.thomas-bayer.com/sqlrest/PRODUCT/#{count[:id]}")).body
    return JSON.parse(Hash.from_xml(s).to_json)
  end

  def get_items(count = {})
    s = Net::HTTP.get_response(URI.parse("http://www.thomas-bayer.com/sqlrest/ITEM/#{count[:id]}")).body
    return JSON.parse(Hash.from_xml(s).to_json)
  end

  def get_invoice(count = {})
    s = Net::HTTP.get_response(URI.parse("http://www.thomas-bayer.com/sqlrest/INVOICE/#{count[:id]}")).body
    return JSON.parse(Hash.from_xml(s).to_json)
  end
end
