
module Common
  class List

    def self.lower_bound(list, key)
      left = -1
      right = list.size

      while left + 1 < right
        mid = left + ((right - left) / 2)
        if list[mid] >= key
          right = mid
        else
          left = mid
        end
      end

      right
    end

    def self.upper_bound(list, key)
      left = -1
      right = list.size

      while left + 1 < right
        mid = left + ((right - left) / 2)
        if list[mid] > key
          right = mid
        else
          left = mid
        end
      end

      right
    end

  end
end

