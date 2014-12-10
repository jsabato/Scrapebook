  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
@item = "samsung+tv"
page = Nokogiri::HTML(open("http://www.newegg.com/Product/ProductList.aspx?Submit=ENE&DEPA=0&Order=BESTMATCH&Description=#{@item}&N=-1&isNodeId=1"))

# # ----------Item Link--------------

# @item_page_link = page.css(".itemCell").css(".itemImage")
# @item_page_link.each{|link| puts link['href']}

# # ----------Item Image--------------

# @item_image = page.css(".itemCell").css(".itemImage").css("img")
# @item_image.each{|link| puts link['src']}

# ----------Item Name--------------

# @item_name = page.css(".itemCell").css(".itemImage")
# @item_name.each{|link| puts link['title']}

# # ----------Item Price--------------

# @item_price = page.css(".itemAction").css('input[name="priceBefore"]')
# @item_price.each{|link| puts link['value']}