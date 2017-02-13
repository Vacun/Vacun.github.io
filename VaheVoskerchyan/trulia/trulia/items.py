# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class TruItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    address = scrapy.Field()
    price = scrapy.Field()
    sqft = scrapy.Field()
    house_type = scrapy.Field()
    bedrooms = scrapy.Field()
    bathrooms = scrapy.Field()
    partial_bathrooms = scrapy.Field()
    build_year = scrapy.Field()
    zip_code = scrapy.Field()
    city = scrapy.Field()
    state = scrapy.Field()
    street = scrapy.Field()
    latitude = scrapy.Field()
    longitude = scrapy.Field()
    neighborhood = scrapy.Field()
    price_per_sqft = scrapy.Field()
    state_code = scrapy.Field()
    url = scrapy.Field()
    listing_id = scrapy.Field()

