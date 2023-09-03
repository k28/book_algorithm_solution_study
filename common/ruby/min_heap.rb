
module Common
  class PriorityQueue

    # 2番目の引数に比較のラムダ式を指定します. 指定しない場合は最小値を返すQueueになります
    def initialize(source, comp = lambda { |x, y| x <= y})
      @comp = comp
      @arr = []
      source.each do |e|
        push e
      end
    end

    def size
      @arr.size
    end

    def empty?
      @arr.empty?
    end

    # ヒープの先頭を返す(削除しません)
    def top
      @arr.first
    end

    def push(value)
      @arr << value
      i = @arr.size - 1

      # 親子関係を修復していきます
      while i > 0
        parent = (i - 1) / 2

        # 関係が逆転していなければ終了
        break if @comp.call(@arr[parent], value)
        
        # 親と自分をswapします
        @arr[parent],  @arr[i] = @arr[i], @arr[parent]

        i = parent
      end

      @arr[i] = value
    end

    # ヒープから先頭を取り出す(削除します)
    def pop
      ret_value = top

      # ヒープを再構築します
      tmp_node = @arr.last
      @arr.pop

      i = 0
      while (i * 2 + 1) < size
        # 左右の子ノードの値を比較して小さい(より真の物)方を選びます
        lhs_child = i * 2 + 1 # 左側の子
        rhs_child = i * 2 + 2 # 右側の子
        min_child = lhs_child # 仮定
        if rhs_child < size
          # 右側の子のindexがサイズを超えていない場合(超えてる時はもう無いという事)
          if !@comp.call(@arr[lhs_child], @arr[rhs_child])
            min_child = rhs_child
          end
        end

        # 逆転していなければ終了
        break if @comp.call(tmp_node, @arr[min_child])

        # 自分のノードを子の値にする
        @arr[i] = @arr[min_child]
        i = min_child
      end

      # 選んだノードは最終的にこの位置に決定
      @arr[i] = tmp_node unless empty?
      ret_value
    end

  end

end

