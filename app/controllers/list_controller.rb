class ListController < ApplicationController

  require 'list_service'
  
  def index
  end
  
  def items
    list_object = ListService.new
    options= {} 
    options[:id] = params[:id]
    params[:category] ||= "1"
    options[:category] = params[:category]
    if params[:id] == nil
      case params[:category]
        when "1" then 
          @lists = list_object.get_customers(options)['CUSTOMERList']['CUSTOMER']
          @category = 'Customer'
        when "2" then 
          @lists = list_object.get_products(options)['PRODUCTList']['PRODUCT']
          @category = 'Product'
        when "3" then 
          @lists = list_object.get_items(options)['ITEMList']['ITEM']
          @lists = @lists.uniq
          @category = 'Item'
        when "4" then 
          @lists = list_object.get_invoice(options)['INVOICEList']['INVOICE']
          @category = 'Invoice'
      end
    end
    respond_to do |format|
        format.js
    end
  end

  def item_details
    list_object = ListService.new
    options= {} 
    options[:id] = params[:id]
    params[:category] ||= "1"
    options[:category] = params[:category]
    @index = params[:id]
    case params[:category]
      when "1" then 
        @list = list_object.get_customers(options)['CUSTOMER']
        @category = 'Customer'
      when "2" then 
        @list = list_object.get_products(options)['PRODUCT']
        @category = 'Product'
      when "3" then 
        @list = list_object.get_items(options)['ITEM']
        @category = 'Item'
      when "4" then 
        @list = list_object.get_invoice(options)['INVOICE']
        @category = 'Invoice'
    end
    respond_to do |format|
        format.js
    end
  end
end

