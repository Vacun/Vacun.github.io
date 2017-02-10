# -*- coding: utf-8 -*-
import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule


class TempletvcrawlSpider(CrawlSpider):
    name = 'templetVcrawl'
    allowed_domains = ['http://www.zillow.com/homes/for_rent/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=rent']
    start_urls = ['http://http://www.zillow.com/homes/for_rent/New-York-NY_rb/?fromHomePage=true&shouldFireSellPageImplicitClaimGA=false&fromHomePageTab=rent/']

    rules = (
        Rule(LinkExtractor(allow=r'Items/'), callback='parse_item', follow=True),
    )

    def parse_item(self, response):
        i = {}
        #i['domain_id'] = response.xpath('//input[@id="sid"]/@value').extract()
        #i['name'] = response.xpath('//div[@id="name"]').extract()
        #i['description'] = response.xpath('//div[@id="description"]').extract()
        return i
