# Nokogiri

#### Gem 설치
```
gem 'nokogiri'
```
```
$ bundle install
```

#### Controller 생성
```
$ rails g controller crawler
```


### 네이버 환율 크롤링하기
 - [네이버 환율 페이지](http://info.finance.naver.com/marketindex/?tabSel=exchange#tab_section)

#### CSS를 이용해서 해당 데이터 찾기
```ruby
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
```

`.`은 class, `#`은 id를 뜻한다. `>`를 이용해 자식태그에 접근할 수 있다. `.text`로 쉽게 안에 들어있는 텍스트내용만을 가져올 수 있다.

```erb
<%= @new_currency.each_with_index do | cur ,index| %>
	<p><%= index %> <%=@new_curname[index]%><%=cur %> </p>
<% end %>
```
`.each_with_index`를 사용하면 index를 불러올 수 있다.