#!/usr/bin/env python

from github import Github
import requests

with open('.github_token', 'r') as f:
        token = f.read()

def main():
        g = Github(token)
        reef_pi = g.get_organization('reef-pi').get_repo('reef-pi')
        releases = reef_pi.get_releases()
        for release in releases:
                for asset in release.get_assets():
                        print asset.name
                        fetch_asset(asset)
        

def fetch_asset(asset):
        with open('tmp/{}'.format(asset.name), 'w') as f:
                r = requests.get(asset.url,
                                 allow_redirects=True,
                                 headers={
                                         'Accept':'application/octet-stream',
                                         'Authorization': 'token {}'.format(token),
                                 })
                f.write(r.content)
        

if __name__ == '__main__':
        main()
