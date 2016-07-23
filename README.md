# UNLV QR Code Scavenger Hunt

Welcome to the UNLV QR Code Scavenger Hunt web app! We hope you'll find
this app fun and exciting.

## Installation

We assume that you've already configured your server to deploy this app.
There are so many different server options for Rails deployment that it
would be unfeasible to cover them all. Thus, after you have set up your
server, simply change into the app main directory and perform these steps:

* run `./install.sh`
* run `bundle exec rake secrets` - make sure to copy the generated hash
* edit `config/secrets.yml` to include the secret hash

That's it! When you first visit the web site, you'll be asked to create
an initial admin account and select some options. After that, it's off
to the races!

## Contribute

Development for this project is done via a private Bitbucket repository.
If you are interested in contributing in any way to this app, please
email the project director, Guymon Hall, at `g u y m o n . h a l l @ g m
a i l . c o m`
