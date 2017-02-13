import scrapy
import json
import re
from trulia.items import TruItem

query = 'NY/New_York/'

class TrulSpider(scrapy.Spider):
	name = 'truliaspider'
	allowed_domains = ["trulia.com"]
	start_urls = ['https://www.trulia.com/'+query]

	def last_pagenumber_in_search(self, response):
		try:
			last_p = response.xpath('//*[@id="resultsColumn"]/div/div[2]/div[2]/div[1]/div[1]/a[6]/@href').extract()
			last_p_split = last_p[0].split('/')
			almost_page = last_p_split[-2]
			almost_there = almost_page.split('_p')
			last_page = int(almost_there[0])
			return last_page
		except:
			return 1

	def parse(self,response):
		last_page_number = self.last_pagenumber_in_search(response)
		page_urls = [response.url + str(pageNumber) +'_p/' 
						for pageNumber in range(1, last_page_number + 1)]
        	for page_url in page_urls:
        		yield scrapy.Request(page_url,callback=self.parse_listing_results_page)

	
	def parse_listing_results_page(self, response):
		for href in response.xpath('//div[@class="containerFluid"]//a/@href').extract():
			url = response.urljoin(href)
			yield scrapy.Request(url, callback=self.parse_listing_contents)

	


	# def json_extract(x):
	# 	x_list = re.split(';',x[0])
	# 	x_json_list=re.split('trulia.pdp.propertyJSON = ',x_list[2])
	# 	return x_json_list[1]

	def parse_listing_contents(self, response):
		item = TruItem()

		res = response.xpath('//script[@type="text/javascript" and contains(text(),"trulia.pdp.propertyJSON")]').extract()
		if res:
			res_list = re.split(';',res[0])
			res_json_list=re.split('trulia.pdp.propertyJSON = ',res_list[2])
			json_content = res_json_list[1]
			
			trulia_json = json.loads(json_content)
			item['address'] = trulia_json['addressForDisplay']
			item['street'] = trulia_json['street']
			item['neighborhood'] = trulia_json['neighborhood']
			item['city'] = trulia_json['city']
			item['state'] = trulia_json['stateName']
			item['state_code'] = trulia_json['stateCode']
			item['zip_code'] = trulia_json['zipCode']
			item['price'] = trulia_json['price']
			item['sqft'] = trulia_json['sqft']
			item['price_per_sqft'] = trulia_json['pricePerSqft']
			item['house_type'] = trulia_json['typeDisplay']
			item['bedrooms'] = trulia_json['numBeds']
			item['bathrooms'] = trulia_json['numBathrooms']
			item['partial_bathrooms'] = trulia_json['numPartialBathrooms']
			item['build_year'] = trulia_json['yearBuilt']
			item['latitude'] = trulia_json['latitude']
			item['longitude'] = trulia_json['longitude']
			item['listing_id'] = trulia_json['id']
		item['url'] = response.url
		yield item



