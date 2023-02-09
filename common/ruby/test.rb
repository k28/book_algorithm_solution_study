#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require './assert.rb'
require './list.rb'

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

