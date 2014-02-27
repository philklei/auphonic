module Auphonic
  class Exec < Struct.new(:args)
    class << self
      def run(args)
        new(args).run
      end
    end

    def run
      usage if args[0] != 'process'
      file = args[1] || usage
      puts 'create new production'
      p1 = Preset.all.first.new_production.save
      puts "upload #{file}"
      p1.upload file
      puts 'start production'
      p1.start
      status = nil
      until status == 'Done'
        sleep 5
        status = p1.reload.data['status_string']
        puts "Status: #{status}"
      end
      puts 'download output files'
      puts *p1.download
    end

    def usage
      puts
      puts 'Usage: auphonic process <file>'
      puts
      exit
    end

    # def parse_args
    #  # TODO
    # end
  end
end
