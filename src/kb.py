"""six degrees of kevin bacon"""
# pylint: disable=import-error, line-too-long, unused-argument
import datetime
import random
import re
import json
from urllib.request import urlopen
from bs4 import BeautifulSoup


def make_wikipedia_url(article_url: str) -> str:
    """Create Wikipedia compatible string"""
    return f'http://en.wikipedia.org{article_url}'


class KevinBacon:
    """Six Degrees of Kevin Bacon Class"""

    urlLinks = []

    def __init__(self, url: str):
        """Initialise class with starting url"""
        self.url = url
        random.seed(int(round(datetime.datetime.now().timestamp())))

    def get_links(self, article_url):
        """Get links from the wikipedia page"""
        with urlopen(make_wikipedia_url(article_url)) as html:
            self.urlLinks.append(make_wikipedia_url(article_url))
            b_soup = BeautifulSoup(html, 'html.parser')
            return b_soup.find('div', {'id': 'bodyContent'}).find_all('a', href=re.compile('^(/wiki/)((?!:).)*$'))   # noqa: 501 pylint: disable=line-too-long

    def six_degrees(self) -> int:
        """six degrees mechanism"""
        self.urlLinks.clear()
        links = self.get_links(self.url)

        while len(links) > 0 and len(self.urlLinks) < 6:
            new_article = links[random.randint(0, len(links)-1)].attrs['href']
            links = self.get_links(new_article)

        return len(self.urlLinks)

    def as_list(self):
        """Return Python List"""
        return self.urlLinks

    def as_json(self):
        """Return JSON List"""
        return json.dumps(self.urlLinks)
