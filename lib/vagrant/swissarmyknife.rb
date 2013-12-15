
require 'bundler/setup'
require 'require_all'
require 'yaml'
require 'singleton'
require 'erb'
require 'choice'

require_all "./lib/vagrant/swissarmyknife/"
#autoload_all "./config/"

module Vagrant
  module Swissarmyknife
    class Application

      Choice.options do
        header ''
        header 'specific options:'
        header ''
        header ''

        option :init do
          long 'init'
          desc 'Initializes the vagrant environment'
          action do
            initialize = Vagrant::Swissarmyknife::Init.new
            initialize.bundler
            initialize.install_vagrant_plugins
            initialize.download_vagrant_boxes
            initialize.import_vagrant_boxes
            initialize.install_templates
          end
        end

        option :uninstall do
          long 'uninstall'
          desc 'Uninstall the vagrant components'
          action do
            initialize = Vagrant::Swissarmyknife::Init.new
            initialize.uninstall
          end
        end


        option :up do
          long 'up'
          desc 'executes vagrant up'
          action do
            operations = Vagrant::Swissarmyknife::Operations.new
            operations.up
          end
        end

        option :provision do
          long 'provision'
          desc 'executes chef-run'
          action do
            operations = Vagrant::Swissarmyknife::Operations.new
            operations.provision
          end
        end

        option :destroy do
          long 'destroy'
          desc 'destroy vagrant vms'
          action do
            operations = Vagrant::Swissarmyknife::Operations.new
            operations.destroy_vagrant_vms
          end
        end

      end
    end
  end
end
