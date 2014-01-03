

def load_config
  @plugins = YAML.load(File.read('plugins.yaml'))
  @boxes = YAML.load(File.read('boxes.yaml'))
end

def box_exist?(name)
  %x{ vagrant box list }.match(name) ? true : false
end

task :default do
  puts "available tasks:"
  puts "setup           -> downloads boxes, installs plugins"
  puts "up              -> vagrant up but not provision"
  puts "provision       -> berks update and vagrant provision"
  puts "install         -> install vagrant plugins"
  puts "download_boxes  -> download the vagrant boxes"
  puts "clean_boxes     -> remove the downloaded vagrant boxes"
  puts "uninstall       -> destroy the VMs and uninstall the vagrant plugins"
  puts "destroy         -> destroy the VMs"
end

task :run_once => [
  :install_templates,
  :install_polipo,
  :start_polipo,
  :set_proxy_env_variables,
  :bundler,
  :install_vagrant_plugins,
  :download_vagrant_boxes,
  :import_vagrant_boxes ] do
end

task :install_templates do
  %w[
     Vagrantfile
     Berksfile
     Gemfile
     plugins.yaml
     boxes.yaml
     polipo.config].each do |tt|

    template = File.read(
      File.expand_path("templates/#{tt}", __FILE__))

    unless File.exists?("#{tt}")
      File.open "#{tt}", 'w', 0755 do |f|
        f.puts ERB.new(template, nil, '-').result(binding)
      end
    end
  end
end

task :install_polipo do
  system("git clone git://git.wifi.pps.univ-paris-diderot.fr/polipo")
  system("cd polipo; make")
  system("mkdir #{ENV['HOME']}/.polipo-cache")
  system("touch #{ENV['HOME']}/.polipo-cache/polipo.log")
end

task :start_polipo do
  system("polipo/polipo -c polipo.config &")
end

task :set_proxy_env_variables do
  ENV['http_proxy']='http://localhost:6060';
  ENV['https_proxy']='https://localhost:6060';
  ENV['HTTP_PROXY']='http://localhost:6060';
  ENV['HTTPS_PROXY']='https://localhost:6060';
end

task :bundler do
  system("bundle install")
end

task :install_vagrant_plugins do
  load_config

  # clean Vagrantfile
  #system("rm Vagrantfile")

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

task :download_vagrant_boxes => [ :set_proxy_env_variables]  do
  @boxes.each_pair do |name,url|
    unless box_exist?(name)
      system("wget -c #{url}")
    end
  end
end

task :import_vagrant_boxes do
  @boxes.each_pair do |name,url|
    unless box_exist?(name)
      system("vagrant box add #{name} #{url}")
    end
  end
end

task :clean_vagrant_boxes do
  @boxes.each_pair do |name,url|
    system("rm #{name}.box")
  end
end


task :setup => [
  :install, :download_boxes, :import_boxes ]

task :install do
  # clean Vagrantfile
  system("rm Vagrantfile")

  # Bindler is going beserk on me, lets fall back to a simple
  # vagrant plugin install
  plugins.each do |x|
    system("vagrant plugin install #{x}")
  end

  # we need the latest vagrant-vbguest
  system("vagrant plugin install --plugin-source http://rubygems.org/ --plugin-prerelease vagrant-vbguest")

  # install good vagrantfile
  system("cp Vagrantfile.latest Vagrantfile")
end

task :uninstall_vagrant_plugins do
  @plugins.each do |x|
    system("vagrant plugin uninstall #{x}")
  end
end

task :destroy_vagrant_vms do
  system("vagrant destroy -f")
end

task :uninstall => [:destroy_vagrant_vms ] do
  # clean Vagrantfile
  system("rm Vagrantfile")

  plugins.each do |x|
    system("vagrant plugin uninstall #{x}")
  end
end

task :bundler do
  system("bundle install")
end


task :provision do
  system("berks update")
  system("vagrant provision")
end

task :up do
  system("vagrant up chefzero")
  system("vagrant up --no-provision")
end

task :destroy do
  system("vagrant destroy -f")
end

task :download_boxes do
  boxes.each_pair do |name,url|
    system("wget -c #{url}")
  end
end

task :import_boxes do
  boxes.each_pair do |name,url|
    system("vagrant box add #{name} #{url}")
  end
end

task :clean_donwloaded_boxes do
  boxes.each_pair do |name,url|
    system("rm #{name}.box")
  end
end
