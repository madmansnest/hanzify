# encoding: utf-8
# Hanzify Web App
#
# Main App

require 'sinatra/base'
require './hanzificator'

class HanzifyApp < Sinatra::Base
  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end
  
  get '/:text' do
    redirect_to '/' if params[:text].nil? || params[:text]==''
    hanzificator = Hanzificator.new
    words = params[:text].split(' ')
    begin
      male = words.map {|word| hanzificator.hanzify(word)}.join('・')
      female = words.map {|word| hanzificator.hanzify(word, female=true)}.join('・')
      if male==female
        return male
      else
        return %Q{<span class="elucidation">(男)</span> #{male}<br><span class="elucidation">(女)</span> #{female}}
      end
    rescue UnsupportedCharactersException
      return '<span class="elucidation">(unsupported characters in input string)</span>'
    end
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
