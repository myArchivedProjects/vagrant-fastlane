module Vagrant
  module Swissarmyknife
    class Setup

      def bundle
        install_vagrant_plugins
        download_vagrant_boxes
        import_vagrant_boxes
      end

      def install_vagrant_plugins
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

      def download_vagrant_boxes
        boxes.each_pair do |name,url|
          system("wget -c #{url}")
        end
      end

      def import_vagrant_boxes
        boxes.each_pair do |name,url|
          system("vagrant box add #{name} #{url}")
        end
      end

      def clean_vagrant_boxes
        boxes.each_pair do |name,url|
          system("rm #{name}.box")
        end
      end

      def uninstall_vagrant_plugins
        # Bindler is going beserk on me, lets fall back to a simple
        # vagrant plugin install
        plugins.each do |x|
          system("vagrant plugin uninstall #{x}")
        end
      end

     def uninstall
       destroy_vagrant_vms
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
        boxes.each_pair do |name,url|
          system("rm #{name}.box")
        end
      end

      def provision
        system("berks update")
        system("vagrant provision")
      end

      def up
        system("vagrant up chefzero")
        system("vagrant up --no-provision")
      end
    end
  end
end

