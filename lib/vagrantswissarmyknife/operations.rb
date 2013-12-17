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

  end
end

