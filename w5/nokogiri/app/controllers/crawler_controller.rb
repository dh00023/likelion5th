require 'open-uri'
class CrawlerController < ApplicationController
	def index
		url="http://info.finance.naver.com/marketindex/?tabSel=exchange#tab_section"
		doc = Nokogiri::HTML(open(url),nil,'euc-kr')
		currency = doc.css('div.head_info > span.value')
		@new_currency = currency.map{ |cur| cur.text }
		cur_name = doc.css('h3.h_lst')
		@new_curname = cur_name.map{ |n| n.text }
	end
end
