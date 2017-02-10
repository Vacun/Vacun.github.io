import scrapy
import json
from Zillow.items import zillosItems

# QUERY = 'New-York-NY'

class ZillowSpider(scrapy.Spider):
	name = 'zillow_rent'
	allowed_domain = ['zillow.com']
	star_urls = ('http://www.zillow.com/homes/for_sale/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=buy')

	def last_pagenumber_in_search(self. response):
		try:
			# here, we are going to find out the number of pages 
			# our responce has. in outher words, we are simply going to
			# scroll down and see how many pages of listing there are, and 
			# then locate the tag that contains that number in it. after
			# extracting that number a text, we will need to to turn it into
			# an integer so that we can use it in a for loop
			# the natural question is, what if there are more listings
			# added next day!? the number of pages will change!! for that we
			# are going to locate the tag by passing to it <tag>[last()] (or 
			# some combination of it). In AirBnb case, we passed li[last()-1]
			last_page_number = int(responce.xpath())



			# the goal is to creat a list with elements being the urls 
			# of each page
			