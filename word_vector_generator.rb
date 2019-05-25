require 'net/http'
require 'uri'

class WordVectorGenerator
  def initialize(generator=:default)
    case generator
    when :default
      @generator = DefaultGenerator
    when :dictionary
      @generator = DictionaryGenerator
    end
  end

  def generate
    @generator.generate
  end
end

class DefaultGenerator
  def self.generate
    ["buku", "baju", "rumah", "komputer"]
  end
end

class DictionaryGenerator
  def self.generate
    resp = Net::HTTP.get(URI.parse('https://raw.githubusercontent.com/geovedi/indonesian-wordlist/master/01-kbbi3-2001-sort-alpha.lst'))
    online_wordlist = resp.split("\n")
    selected_vec = online_wordlist.select {|item| item.length >= 3}
    selected_vec
  end
end