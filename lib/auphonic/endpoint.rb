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
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      config = OpenStruct.new(YAML.load(File.read(File.expand_path("~/.auphonic"))))
      credentials = [ config.login, config.passwd ]
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

    private

    def get(url)
      JSON.parse(@connection.get(url).body)
    end

  end
end
