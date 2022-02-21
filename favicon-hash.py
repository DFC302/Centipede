import sys
import os
import mmh3
import requests
import codecs
import sys
import tldextract
import concurrent.futures

from urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

def concurrency():
    urls = []

    if not os.isatty(0):
        for url in sys.stdin:
            url = url.strip("\n")
            urls.append(url)

        with concurrent.futures.ThreadPoolExecutor(max_workers=30) as executor:
            for _ in executor.map(getHash, urls):
                pass

def getHash(url):
    try:
        response = requests.get(url, timeout=5, verify=False)
        favicon = codecs.encode(response.content, "base64")
        hash = mmh3.hash(favicon)

        extracted = tldextract.extract(url)
        ext_domain = '.'.join(extracted[:3])

        if hash != 0:
            print(f"{ext_domain}\thttp.favicon.hash:{hash}")

    except Exception as e:
        print(e)

def main():
    concurrency()

if __name__ == "__main__":
    main()
