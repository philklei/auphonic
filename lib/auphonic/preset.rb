module Auphonic
  class Preset < Base

    def new_production
      Production.new preset: uuid
    end

  end
end
    
