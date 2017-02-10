from selenium import webdriver
from selenium.webdriver.common.by import By
import time

driver = webdriver.Chrome()
driver.get('http://www.zillow.com/homes/for_sale/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=buy')

# successful clicking in a website
# driver.get('https://en.wikipedia.org/wiki/Armenia')
# driver.find_elements_by_xpath('//*[@id="mw-content-text"]/p[17]/a[1]')[0].click()
# OR
# list1 = driver.find_elements_by_xpath('//*[@id="mw-content-text"]/p[17]/a[1]')
# list1[0].click()

listings = driver.find_elements_by_xpath('//*[@id="search-results"]/ul/li')
print len(listings)

listings[0].find_elements_by_tag_name('a')[0].click()
time.sleep(2)
# this is to click the 'show more' and expand the list of features
driver.find_element_by_xpath('//div[@class="zsg-g_gutterless"]//a[1]').click()

# now the fun part of scraping itself
time.sleep(1)

# driver.find_element_by_xpath('//section[@class="zsg-content-section"]')
address = driver.find_element_by_xpath('//header/h1/*').text
print address
price = driver.find_element_by_xpath('//div[@class="estimates"]/div[2]').text
print price
try:
	zprice = driver.find_element_by_xpath('//div[@class="estimates"]/div[3]/span[2]').text
	print zprice
except:
	print 'No Zprice'
bedrooms = driver.find_element_by_xpath('//header/h3/span[2]').text
print bedrooms
bathrooms = driver.find_element_by_xpath('//header/h3/span[4]').text
print bathrooms
floor_size = driver.find_element_by_xpath('//header/h3/span[6]').text
print floor_size
est_mortgage = driver.find_element_by_xpath('//div[@class="loan-calculator-container"]//span[1]/span').text
print est_mortgage



