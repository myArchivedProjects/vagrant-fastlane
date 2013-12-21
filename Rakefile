require "bundler/gem_tasks"

task :default do
end

task :rebuild do
  system ('gem uninstall -q vagrant-swissarmyknife ')
  system ('gem build vagrant-swissarmyknife.gemspec')
  system('gem install vagrant-swissarmyknife-0.0.1.gem')
end


