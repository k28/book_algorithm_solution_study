#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require './assert.rb'
require './list.rb'
require './priority_queue.rb'

Common::Assert.equal(0, Common::List.lower_bound([2,2,5,5,9], 2))
Common::Assert.equal(2, Common::List.lower_bound([2,2,5,5,9], 4))
Common::Assert.equal(2, Common::List.lower_bound([2,2,5,5,9], 5))
Common::Assert.equal(4, Common::List.lower_bound([2,2,5,5,9], 7))
Common::Assert.equal(5, Common::List.lower_bound([2,2,5,5,9], 100))

Common::Assert.equal(2, Common::List.upper_bound([2,2,5,5,9], 2))
Common::Assert.equal(2, Common::List.upper_bound([2,2,5,5,9], 4))
Common::Assert.equal(4, Common::List.upper_bound([2,2,5,5,9], 5))
Common::Assert.equal(4, Common::List.upper_bound([2,2,5,5,9], 7))
Common::Assert.equal(5, Common::List.upper_bound([2,2,5,5,9], 100))

# min_heap test
min_heap = Common::PriorityQueue.new([3, 5, 7, 1])
Common::Assert.equal(4, min_heap.size)
Common::Assert.equal(false, min_heap.empty?)
Common::Assert.equal(1, min_heap.top)
Common::Assert.equal(1, min_heap.pop)
Common::Assert.equal(3, min_heap.size)
Common::Assert.equal(3, min_heap.pop)
Common::Assert.equal(5, min_heap.pop)
Common::Assert.equal(7, min_heap.pop)
Common::Assert.equal(true, min_heap.empty?)
Common::Assert.equal(nil, min_heap.pop)
min_heap.push(7)
min_heap.push(5)
min_heap.push(13)
Common::Assert.equal(5, min_heap.pop)

max_heap = Common::PriorityQueue.new([3, 5, 7, 1], lambda { |x, y| x >= y})
Common::Assert.equal(4, max_heap.size)
Common::Assert.equal(false, max_heap.empty?)
Common::Assert.equal(7, max_heap.top)
Common::Assert.equal(7, max_heap.pop)
Common::Assert.equal(3, max_heap.size)
max_heap.push 13
Common::Assert.equal(13, max_heap.top)
max_heap.push 2
Common::Assert.equal(13, max_heap.top)
Common::Assert.equal(5, max_heap.size)

