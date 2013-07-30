# encoding: utf-8
# Hanzify Web App
#
# Hanzificator Module Test
#
# Write any name in Chinese according to the official transliteration rules.
#
# So far, only Russian names are supported.
# 
# Copyright © 2012-2013 Demian Terentev <demian@infusiastic.me>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'minitest/autorun'
# require 'minitest/colorize'
require './app/hanzificator'

describe Hanzificator do
  it "must syllabize open syllables" do
    Hanzificator.new.syllabize("яма").must_equal ['я','ма']
  end
  
  it "must syllabize consecutive open syllables" do
    Hanzificator.new.syllabize("молоко").must_equal ['мо','ло','ко']
  end
  
  it "must not syllabize closed syllables" do
    Hanzificator.new.syllabize("тарантас").must_equal ['та','рантас']
  end
  
  it "must correctly hanzify names with open syllables" do
    Hanzificator.new.hanzify("Афанасий").must_equal "阿法纳西"
  end
  
  it "must correctly hanzify male names" do
    Hanzificator.new.hanzify("Ширяев", :male).must_equal "希里亚耶夫"
  end
  
  it "must correctly hanzify female names" do
    Hanzificator.new.hanzify("Ева", :female).must_equal "叶娃"
  end
  
  it "must correctly hanzify place names" do
    Hanzificator.new.hanzify("Сибай", :place).must_equal "锡拜"
  end
end