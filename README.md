# Vagrant-fastlane

More than a boilerplate, it speeds up your cookbook development by caching
agressively your objects, installing vagrant plugins for you and downloading
required vagrant boxes.

Features:

* runs a personal polipo caching server on port 6060
* installs a list of vagrant plugins for you
* installs gem bundler and and a bunch of gems into your vendor folder
* sets a new vagrantfile which:
   - installs latest virtualbox modules
   - installs latest chef client
   - prepares a running chef-zero server on a dedicated VM
   - runs berkshelf and upload all your cookbooks from your berksfile
   - configures your VMs so that they connect to your polipo caching server

Your cached objects are kept under your homedir in a .polipo-cache folder.
The configuration is defined on a set of files bundled into this repository.

* polipo.config (no need to tamper with it)
* plugins.yaml (add new vagrant-plugins to it if you wish)
* boxes.yaml (add new vagrant boxes to this list to download and import)
* Gemfile (and new gems if needed)
* Berksfile (define the list of your cookbooks)
* Vagrantfile (adjust your VMs)

## Installation

install it as:

    use rbenv/rvm/chruby to switch to your personal ruby

    then:

    $ rake run_once

## Usage

Edit the Vagrantfile and the Berskfile adding all the cookbooks you may need

    $ vim Vagrantfile
    $ vim Berksfile
    $ rake up
    $ rake provision
    $ vagrant ssh <boxname>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
