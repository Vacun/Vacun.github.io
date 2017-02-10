# -*- coding: utf-8 -*-
import scrapy


class TempletvSpider(scrapy.Spider):
    name = "templetV"
    allowed_domains = ["http://www.zillow.com/homes/for_rent/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=rent"]
    start_urls = ['http://http://www.zillow.com/homes/for_rent/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=rent/']

    def parse(self, response):
        pass
