# encoding: utf-8
# Hanzify Web App
#
# Main App
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

require 'sinatra/base'
require './hanzificator'

class HanzifyApp < Sinatra::Base
  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end
  
  get '/hanzify' do
    redirect_to '/' if params[:q].nil? || params[:q]==''
    hanzificator = Hanzificator.new
    words = params[:q].split(/[ -]/) # treat hyphens as spaces
    begin
      mode = params[:mode].to_sym unless params[:mode].nil?
      mode = :male unless [:female, :place].include? mode
      result = words.map {|word| hanzificator.hanzify(word, mode)}.join('·')
      return result
    rescue UnsupportedCharactersException
      return '<span class="elucidation">(unsupported characters in input string)</span>'
    end
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
