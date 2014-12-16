require 'singleton'
require 'faraday'
require 'yaml'
require 'ostruct'
require 'json'

module Auphonic
  class Endpoint

    include Singleton

    URL = 'https://auphonic.com'

    def initialize
      @connection ||= Faraday.new(:url => URL) do |faraday|
        faraday.request :multipart
        #faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
      config = YAML.load(ERB.new(File.read("#{Rails.root}/config/auphonic.yml")).result)[Rails.env].symbolize_keys!
      credentials = [ config[:login], config[:password] ]
      @connection.basic_auth(*credentials)
    end

    def productions
      get('/api/productions.json')['data']
    end

    def presets
      get('/api/presets.json')['data']
    end

    def services
      get('/api/services.json')['data']
    end

    def info_servicetypes
      get('/api/info/service_types.json')['data']
    end

    def info_algorithms
      get('/api/info/algorithms.json')['data']
    end

    def info_outputfiles
      get('/api/info/output_files.json')['data']
    end

    def info_productionsstatuss # sic
      get('/api/info/production_status.json')['data']
    end

    def load_production(uuid)
      get("/api/production/#{uuid}.json")['data']
    end

    def create_production(data)
      url = '/api/productions.json'
      response = @connection.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json
      end
      JSON.parse(response.body)['data']
    end

    def upload_to_production(uuid, path)
      raise 'Error: uuid missing' if uuid.nil?
      url = "/api/production/#{uuid}/upload.json"
      payload = { input_file: Faraday::UploadIO.new(path, 'audio/basic') }
      response = @connection.post(url, payload)
      JSON.parse(response.body)['data']
    end

    def start_production(uuid)
      url = "/api/production/#{uuid}/start.json"
      response = @connection.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
      end
      JSON.parse(response.body)['data']
    end

    def download(url)
      url.sub!(URL, '')
      filename = File.basename(url)
      response = @connection.get(url)
      File.open(filename, 'w') { |f| f.print(response.body) }
      filename
    end
    
    def download_url(url)
      url.sub!(URL, '')
      response = @connection.get(url)
      response
    end

    # def post(url, &bloc)
    #   puts '=' * 80
    #   puts "POST #{url}"
    #   puts '=' * 80
    #   response = @connection.post url, bloc
    #   result = JSON.parse(response.body)
    #   return result['data'] if result['status_code'] == 200
    #   # error
    #   result['data'] = nil
    #   pp result
    #   exit
    # end

    private

    def get(url)
      response = @connection.get(url)
      JSON.parse(response.body)
    end

  end
end
