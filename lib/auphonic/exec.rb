require 'faraday'
require 'yaml'
require 'ostruct'
require 'json'
require 'pp'

module Auphonic
  class Exec < Struct.new(:args)
    class << self
      def run(args)
        new(args).run
      end
    end

    ENDPOINT = 'https://auphonic.com'

    def run
      # parse_args
      # puts args
      #pp Production.all
      #pp Preset.all
      #pp Service.all
      pp Info::ServiceType.all
    end

    # def parse_args
    #  # TODO
    # end
  end
end
