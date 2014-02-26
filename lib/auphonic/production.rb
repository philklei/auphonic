module Auphonic
  class Production < Base
    
    def save
      self.data = Endpoint.instance.create_production(self.data)
      self
    end

    def upload(path)
      self.data = Endpoint.instance.upload_to_production(uuid, path)
      self
    end

    def start
      self.data = Endpoint.instance.start_production(uuid)
      self
    end

    def reload
      self.data = Endpoint.instance.load_production(uuid)
      self
    end

    def download
      data['output_files'].map do |out|
        Endpoint.instance.download(out['download_url'])
      end
    end

  end
end
