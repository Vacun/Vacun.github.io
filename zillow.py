from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
import time
import csv

driver = webdriver.Chrome()
driver.get('http://www.zillow.com/homes/for_sale/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=buy')
driver.maximize_window()
#driver.manage().window().maximize()
# successful clicking in a website
# driver.get('https://en.wikipedia.org/wiki/Armenia')
# driver.find_elements_by_xpath('//*[@id="mw-content-text"]/p[17]/a[1]')[0].click()
# OR
# list1 = driver.find_elements_by_xpath('//*[@id="mw-content-text"]/p[17]/a[1]')
# list1[0].click()

last_page = int(driver.find_element_by_xpath('//ol[@class="zsg-pagination"]//li[last()-1]').text)
#print last_page
page = 0
count = 0

csv_file = open('listings.csv', 'wb')
fieldnames=['address','price','floor_size','bathrooms','bedrooms','est_mortgage', 'zprice','latitude','longitude','FACTS','FEATURES','APPLIANCES INCLUDED','ROOM TYPES','CONSTRUCTION','ADDITIONAL FEATURES','OTHER']
writer = csv.DictWriter(csv_file,fieldnames=fieldnames)
#writer.writerow(['bathrooms', 'price', 'bedrooms', 'longitude', 'est_mortgage', 'zprice', 'address', 'latitude', 'floor_size','FEATURES','APPLIANCES INCLUDED','OTHER','CONSTRUCTION','ROOM TYPES','ADDITIONAL FEATURES'])
writer.writeheader()
for i in range(last_page):
	page =page + 1
	n = 0
	listings = driver.find_elements_by_xpath('//*[@id="search-results"]/ul/li')
		
	for i  in range(len(listings)):
		n=i+1

		listing_dict = {}

		print 'Scraping the listing number {0} on page {1}, the count is {2}'.format(n,page,count)
		if (count)%11==0:
			listings = driver.find_elements_by_xpath('//*[@id="search-results"]/ul/li')
			time.sleep(2)

		try:
			latitude = listings[i].find_element_by_xpath('./article').get_attribute('data-latitude')
			longitude = listings[i].find_element_by_xpath('./article').get_attribute('data-longitude')
			print 'latitude = {0}, longitude = {1}'.format(latitude,longitude)
			listing_dict['latitude'] = latitude
			listing_dict['longitude'] = longitude
		except:				
			print 'No data'

		try:
			listings[i].find_elements_by_tag_name('a')[0].click()
			time.sleep(2)
			
			# this is to click the 'show more' and expand the list of features
			driver.find_element_by_xpath('//div[@class="zsg-g_gutterless"]//a[1]').click()
			count+=1

			# now the fun part of scraping itself
			time.sleep(2)
			# driver.find_element_by_xpath('//section[@class="zsg-content-section"]')
			try:
				address = driver.find_element_by_xpath('//header/h1').text
				print address
				listing_dict['address'] = address
			except:
				print 'No Address'
			try:
				price = driver.find_element_by_xpath('//div[@class="estimates"]/div[2]').text
				print price
				listing_dict['price'] = price
			except:
				print 'No Price'
			try:
				zprice = driver.find_element_by_xpath('//div[@class="estimates"]/div[3]/span[2]').text
				print zprice
				listing_dict['zprice'] = zprice
			except:
				print "No Zprice"
			try:				
				bedrooms = driver.find_element_by_xpath('//header/h3/span[2]').text
				print bedrooms
				listing_dict['bedrooms'] = bedrooms
			except:
				print "No Bedrooms"
			try:
				bathrooms = driver.find_element_by_xpath('//header/h3/span[4]').text
				print bathrooms
				listing_dict['bathrooms'] = bathrooms
			except:
				print 'No Bathrooms'	
			try:	
				floor_size = driver.find_element_by_xpath('//header/h3/span[6]').text
				print floor_size
				listing_dict['floor_size'] = floor_size
			except:
				print 'No floor size'
			try:
				est_mortgage = driver.find_element_by_xpath('//div[@class="loan-calculator-container"]//span[1]/span').text
				print est_mortgage
				listing_dict['est_mortgage'] = est_mortgage
			except:
				print 'No loan Calculater'

			facts = driver.find_elements_by_xpath('//section[@class="zsg-content-section "]/div[2]/div')
			facts_dict = {}
			for i in range(1,len(facts)-1):
				features = facts[i].find_element_by_xpath('h3').text
				features_content_list = facts[i].find_elements_by_xpath('.//ul')
				features_content = ''
				for things in features_content_list:
					features_content = features_content+'\n'+things.text
				facts_dict[features] = features_content
			listing_dict.update(facts_dict)
			try:
				writer.writerow(listing_dict)
				print 'DATA CAPTURED'
			except:
				print 'It GOT AWAY'

			driver.find_element_by_xpath('//*[@id="actionBar"]/ul[2]/li[2]/button/span').click()

			try:
				driver.find_element_by_xpath('//*[@id="actionBar"]/ul[2]/li[2]/button/span').click()
			except:
				try:
					driver.switch_to_frame("register_content")
					driver.find_element_by_xpath('//div[@id="register_content"]/a').click()
					driver.switch_to_default_content()
				except:
					continue
		except:
			try:
				driver.switch_to_frame("register_content")
				driver.find_element_by_xpath('//div[@id="register_content"]/a').click()
				driver.switch_to_default_content()
			except:
				continue

		
	driver.find_element_by_xpath('//div[@id="search-pagination-wrapper"]//li[@class="zsg-pagination-next"]').click()
	time.sleep(2)
csv_file.close()
driver.close()
