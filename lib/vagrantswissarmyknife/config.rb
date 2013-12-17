
module VagrantSwissArmyKnife
  class Config

    def boxes
      @boxes = YAML.load(File.read('config/boxes.yaml'))
    end

    def plugins
      @plugins = YAML.load(File.read('config/plugins.yaml'))
    end

    def load_config
      return [ plugins, boxes ]
    end

  end
end

