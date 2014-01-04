# Vagrant-fastlane

More than a boilerplate, it speeds up your cookbook development by caching
agressively your objects.

On install it sets a personal polipo instance running on port 6060, your VMs
will connect to it avoid retriving the same objects over and over.
All polipo cache is kept on your homedir under .polipo-cache

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
