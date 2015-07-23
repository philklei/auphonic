module Auphonic
  class User < Base
    
    def self.info
      Endpoint.instance.user_info
    end
    
  end
end