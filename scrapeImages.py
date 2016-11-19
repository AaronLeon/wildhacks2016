import os
from icrawler.examples import GoogleImageCrawler

_QUERY = "photos of normal faces -drawing -art -cartoon -funny"
_DIR = "training_data/regular"

if not os.path.exists(_DIR):
    os.makedirs(_DIR)


google_crawler = GoogleImageCrawler(_DIR)
google_crawler.crawl(keyword=_QUERY, offset=0, max_num=1000,
    date_min=None, date_max=None, feeder_thr_num=1,
    parser_thr_num=1, downloader_thr_num=4,
    min_size=(200,200), max_size=None)
