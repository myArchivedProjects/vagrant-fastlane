
module VagrantSwissArmyKnife
  class Operations

    def provision
      system("berks update")
      system("vagrant provision")
    end

    def up
      system("vagrant up chefzero")
      system("vagrant up --no-provision")
    end

    def destroy_vagrant_vms
      system("vagrant destroy -f")
    end

    def start_polipo
      puts ENV['http_proxy']
      system("polipo/polipo -c polipo.config &")
    end

    def set_proxy_env_variables
      ENV['http_proxy']='http://localhost:6060';
      ENV['https_proxy']='https://localhost:6060';
      ENV['HTTP_PROXY']='http://localhost:6060';
      ENV['HTTPS_PROXY']='https://localhost:6060';
    end

  end
end

