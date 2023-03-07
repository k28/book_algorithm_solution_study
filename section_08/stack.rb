#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# RubyでのStackの実験
# push/popを使ったStackを実現できる
#

stack = []
stack.push(1)
stack.push(3)
stack.push(5)
stack.push(7)

pp stack.length # 4
pp stack.pop    # 7
pp stack.length # 3

