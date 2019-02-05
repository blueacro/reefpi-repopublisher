# reefpi-repopublisher

This project will pull releases from the main reef-pi project
( https://github.com/reef-pi/reef-pi ) and publishes an apt repository
for upgrades and easy installation of Reef-Pi.

# Installing reef-pi from the repository

Run the setup script on the console or Terminal application on your
Reef-Pi system:

    curl -s http://repo.blueacro.com/setup.sh | bash
    
This will setup everything and install the latest version of reef-pi

# Running the publisher

You will need:
- An AWS S3 bucket and credentials to write and list the bucket, as well as set ACLs to public.
- A GitHub personal access token
- An installation of `reprepro`
- A GPG key used for signing packages
- An installation of the Python `virutalenv` tool.

The `./build.sh` script will attempt to build and install all tools, and
publish the repository. Customization should happen to this script.