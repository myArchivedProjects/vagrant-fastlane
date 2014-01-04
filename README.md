# Vagrant-fastlane

More than a boilerplate, it speeds up your cookbook development by caching
agressively your objects, installing vagrant plugins for you and downloading
required vagrant boxes.

Features:

* Cooks you your favourite sandwich on wheat free bread
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

Uses the following plugins:

* vagrant-vbguest         -> updates your virtualbox modules
* vagrant-windows         -> winRM support
* vagrant-omnibus         -> installs latest chef client
* vagrant-proxyconf       -> configures VMs to use your polipo cache
* vagrant-berkshelf       -> populates your chef0 with your cookbooks
* vagrant-hostmanager     -> manages /etc/hosts
* vagrant-cachier         -> caches your objects
* vagrant-chefzero        -> and in-memory chef-server
* vagrant-ohai            -> set your hostname to your internal ip


## Installation

installation steps:

use rbenv/rvm/chruby to switch to your personal ruby

Clone this repository locally

    $ git clone https://github.com/Azulinho/Vagrant-fastlane

Rename it to your new project name

    $ mv Vagrant-fastlane <your project name>
    $ cd <your project name>

And re-initialize the git repositor for your own project

    $ git init

then:

    $ rake run_once

## Usage

Edit the Vagrantfile and the Berskfile adding all the cookbooks you may need

    $ vim Vagrantfile
    $ vim Berksfile
    $ rake up
    $ rake provision
    $ vagrant ssh <boxname>

Update your boxes and plugins by:

    $ vim boxes.yaml
    $ vim plugins.yaml
    $ rake install_vagrant_plugins
    $ rake download_vagrant_boxes
    $ rake import_vagrant_boxes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
