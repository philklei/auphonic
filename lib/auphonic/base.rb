module Auphonic
  class Base < Struct.new(:data)
    
    class << self
      def all
        method = self.name.downcase.gsub('::', '_').sub('auphonic_', '') + 's'
        raise 'Please do not call base directly' if method == 'bases'
        Endpoint.instance.send(method).map { |data| new(data) }
      end
    end

    def uuid
      data['uuid']
    end
    
  end
end
