
module VagrantSwissArmyKnife
  class Init

    def initialize
    end

    def setup
      @plugins, @boxes = load_config
    end

    def boxes
      @boxes = YAML.load(File.read('boxes.yaml'))
    end

    def plugins
      @plugins = YAML.load(File.read('plugins.yaml'))
    end

    def load_config
      return [ plugins, boxes ]
    end

    def bundle
      install_vagrant_plugins
      download_vagrant_boxes
      import_vagrant_boxes
    end

    def install_templates
      %w[Vagrantfile Berksfile Gemfile plugins.yaml boxes.yaml].each do |tt|

        template = File.read(
          File.expand_path("../../../templates/#{tt}", __FILE__))

        unless File.exists?("#{tt}")
          File.open "#{tt}", 'w', 0755 do |f|
            f.puts ERB.new(template, nil, '-').result(binding)
          end
        end
      end
    end

    def install_vagrant_plugins
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

    def box_exist?(name)
      %x{ vagrant box list }.match(name) ? true : false
    end

    def download_vagrant_boxes
      @boxes.each_pair do |name,url|
        unless box_exist?(name)
          system("wget -c #{url}")
        end
      end
    end

    def import_vagrant_boxes
      @boxes.each_pair do |name,url|
        unless box_exist?(name)
          system("vagrant box add #{name} #{url}")
        end
      end
    end

    def clean_vagrant_boxes
      @boxes.each_pair do |name,url|
        system("rm #{name}.box")
      end
    end

    def uninstall_vagrant_plugins
      # Bindler is going beserk on me, lets fall back to a simple
      # vagrant plugin install
      @plugins.each do |x|
        system("vagrant plugin uninstall #{x}")
      end
    end

   def uninstall
     Vagrant::Swissarmyknife::Operations.destroy_vagrant_vms
     system("rm Vagrantfile")
     uninstall_vagrant_plugins
   end

   def bundler
     system("bundle install")
   end

    def destroy_vagrant_vms
      system("vagrant destroy -f")
    end

    def clean_downloaded_boxes
      @boxes.each_pair do |name,url|
        system("rm #{name}.box")
      end
    end

  end #class Init
end

