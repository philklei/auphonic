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
      file = args.first
      puts 'create'
      p1 = Preset.all.first.new_production.save
      puts 'upload'
      p1.upload file
      puts 'start'
      p1.start
      status = nil
      while status != 'Done'
        sleep 1
        status = p1.reload.data['status_string']
        puts "Status: #{status}"
      end
      puts 'download'
      p1.download
    end

    # def parse_args
    #  # TODO
    # end
  end
end
