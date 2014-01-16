require 'erb'
require 'yaml'

def load_config
  @plugins = YAML.load(File.read('plugins.yaml'))
  @boxes = YAML.load(File.read('boxes.yaml'))
end

def box_exist?(name)
  %x{ vagrant box list }.match(name) ? true : false
end

def set_proxy_env_variables
  ENV['http_proxy']='http://localhost:6060';
  ENV['https_proxy']='https://localhost:6060';
  ENV['HTTP_PROXY']='http://localhost:6060';
  ENV['HTTPS_PROXY']='https://localhost:6060';
end

task :default do
  puts "available tasks:"
  puts "run_once        -> downloads all required components"
  puts "start_polipo    -> starts polipo caching server"
  puts "provision       -> berks update and vagrant provision"
  puts "up              -> vagrant up --no-provision"
  puts "halt            -> vagrant halt"
  puts "destroy         -> destroy the VMs"
  puts "uninstall       -> destroy the VMs and uninstall the vagrant plugins"
  puts "destroy         -> destroy the VMs"
end

task :run_once => [
  :install_polipo,
  :start_polipo,
  :set_proxy_env_variables,
  :bundler,
  :install_vagrant_plugins,
  :download_vagrant_boxes,
  :import_vagrant_boxes ] do
end

task :install_polipo do
  system("git clone git://git.wifi.pps.univ-paris-diderot.fr/polipo")
  system("cd polipo; git checkout tags/polipo-1.0.4.1 ; make")
  system("mkdir #{ENV['HOME']}/.polipo-cache")
  system("touch #{ENV['HOME']}/.polipo-cache/polipo.log")
end

task :start_polipo do
  system("polipo/polipo -c polipo.config &")
end

task :bundler do
  set_proxy_env_variables
  system("gem install bundler")
  system("bundle install --path vendor")
end

task :install_vagrant_plugins do
  set_proxy_env_variables
  load_config

  # Bindler is going beserk on me, lets fall back to a simple
  # vagrant plugin install
  @plugins.each_pair do |x,y|
    system("vagrant plugin uninstall #{x}")
    system("vagrant plugin install #{x} --plugin-version #{y}")
  end

  # we need the latest vagrant-vbguest
  # remind me why!
  # move this to vagrant-bundler
  cli = %w[vagrant plugin install
   --plugin-source http://rubygems.org/
   --plugin-prerelease vagrant-vbguest ].join(' ')
  system(cli)
end

task :download_vagrant_boxes do
  set_proxy_env_variables
  load_config

  @boxes.each_pair do |name,url|
    unless box_exist?(name)
      system("wget -c #{url}")
    end
  end
end

task :import_vagrant_boxes do
  load_config
  @boxes.each_pair do |name,url|
    unless box_exist?(name)
      system("vagrant box add #{name} #{url.split('/').last}")
    end
  end
end

task :clean_vagrant_boxes do
  @boxes.each_pair do |name,url|
    system("rm #{name}.box")
  end
end

task :uninstall_vagrant_plugins do
  @plugins.each do |x|
    system("vagrant plugin uninstall #{x}")
  end
end

task :destroy do
  system("vagrant destroy -f")
end

task :uninstall => [ :destroy_vagrant_vms,
                     :uninstall_vagrant_plugins ] do
  load_config
  # clean Vagrantfile
  system("rm Vagrantfile")

  @plugins.each do |x|
    system("vagrant plugin uninstall #{x}")
  end
end

task :bundler do
  set_proxy_env_variables
  system("bundle install")
end

task :provision do
  system("bundle exec berks update")
  system("vagrant provision")
end

task :up do
  system("vagrant up chefzero")
  system("vagrant up --no-provision")
end

task :halt do
  system("vagrant halt")
end

task :clean_donwloaded_boxes do
  load_config

  @boxes.each_pair do |name,url|
    system("rm #{url.split('/').last}")
  end
end
