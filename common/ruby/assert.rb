
module Common
  class Assert

    def self.equal(expected, actual)
      if expected != actual
        pp "Failed! Expected #{expected}, but #{actual}. #{caller.first}"
        exit -1
      end
    end

  end
end

