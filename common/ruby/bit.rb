

module Common
  class BIT

    @bit = []
    @N = 0

    def initialize(size)
      @N = size
      @bit = Array.new(@N + 1, 0)
    end

    # 追加, a: index (1オリジン), w: 追加する値
    def add(a, w)
      x = a + 1
      while (x <= @N)
        @bit[x] += w
        x += (x & -x)
      end
    end

    # a番目までの累積和 (1オリジン)
    def sum(a)
      ret = 0
      x = a
      while (x > 0)
        ret += @bit[x]
        x -= (x & -x)
      end

      ret
    end

    def print()
      "BIT: #{@bit}"
    end

  end
end

