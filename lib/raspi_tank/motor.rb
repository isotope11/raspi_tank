module RaspiTank
  class Motor
    def initialize(options={})
      @forward  = options.fetch(:forward){  raise "forward must be specified"  }
      @backward = options.fetch(:backward){ raise "backward must be specified" }
      @enable   = options.fetch(:enable){   raise "enable must be specified"   }
    end
  end
end
