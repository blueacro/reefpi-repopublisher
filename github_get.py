#!/usr/bin/env python

from github import Github
import requests

import argparse
import os

user_home = os.path.expanduser('~')
with open(os.path.join(user_home, '.github_token'), 'r') as f:
        token = f.read()

def main():
        parser = argparse.ArgumentParser()
        parser.add_argument('--output', dest='output', default='.')
        args = parser.parse_args()
        
        g = Github(token)
        reef_pi = g.get_organization('reef-pi').get_repo('reef-pi')
        releases = reef_pi.get_releases()
        for release in releases:
                for asset in release.get_assets():
                        print asset.name
                        fetch_asset(asset, dest=args.output)
        

def fetch_asset(asset, dest=None):
        fname = '{}/{}'.format(dest, asset.name)
        if os.path.isfile(fname):
                print("file exists {}".format(fname))
                return
        with open('{}/{}'.format(dest, asset.name), 'w') as f:
                r = requests.get(asset.url,
                                 allow_redirects=True,
                                 headers={
                                         'Accept':'application/octet-stream',
                                         'Authorization': 'token {}'.format(token),
                                 })
                f.write(r.content)
        

if __name__ == '__main__':
        main()
