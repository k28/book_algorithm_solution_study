#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# カッコの組を求める
#

LEFT = "("

def check(parenthesis)
  stack = []
  res = []
  (0...parenthesis.length).each do |i|
    s = parenthesis[i]
    if s == LEFT
      stack.push(i)
    else
      # ')'の数が多い
      return false if stack.empty?
      l = stack.pop
      res.push([l, i])
    end
  end

  # '('の数が多い
  return false if !stack.empty?

  return res.reverse
end

# pp check("(((())))")
pp check("((()())())")
