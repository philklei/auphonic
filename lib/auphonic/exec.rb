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
      raise 'No.' unless args[0] != 'process'
      file = args[1]
      puts 'create new production'
      p1 = Preset.all.first.new_production.save
      puts "upload #{file}"
      p1.upload file
      puts 'start production'
      p1.start
      status = nil
      while status != 'Done'
        sleep 5
        status = p1.reload.data['status_string']
        puts "Status: #{status}"
      end
      puts 'download output files'
      p1.download
    end

    # def parse_args
    #  # TODO
    # end
  end
end
