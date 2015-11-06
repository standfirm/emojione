require 'json'
require 'pathname'
require 'pp'
require 'base64'
require 'erb'
require 'yaml'

root = Pathname(File.dirname(__FILE__)).join('..','..')
content = root.join('emoji_strategy.json').read

map = {}
JSON.parse(content).map do |name, value|
  unicode = value['unicode'].split('-').map {|chr|
    chr.to_i(16)
  }.pack('U*')

  data = root.join('assets', 'png', value['unicode'] + '.png').read
  base64 = Base64.encode64(data).strip

  map[unicode] = base64
end

puts({ "emoji" => map}.to_yaml )
