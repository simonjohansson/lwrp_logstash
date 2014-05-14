require 'nokogiri'
require 'open-uri'
require 'yaml'

def scrape(base_path, doc)
      url = URI::join(base_path, doc.values[0])
      Nokogiri::HTML(open(url))
end

def find_all(base_path, base_doc)
  data = {
      'inputs' => [],
      'outputs' => []
  }
  ['inputs', 'outputs'].each do |path|
    base_doc.xpath("//a[contains(@href,'#{path}/')]").each do |link|
      data[path] << scrape(base_path, link)
     end
  end 
  data 
end

def parse_line(line)
    name, data = line.split "=>"
    required = data.include? "(required)"
    {'name' => name.strip, 'required' => required}
end

def parse(input)
    data = {}
    data['name'] = input.xpath('//h2')[0].content
    input.xpath('//code[contains(text(), "input {") or contains(text(), "output {")]').each do |options|
        lines = (options.content.split "\n").select {|a| a.include? "=>" }
        data['options'] = lines.map { |line| parse_line(line) } 
    end  
    data
end

def go()
    base_path = "http://logstash.net/docs/1.4.1/"
    base_doc = Nokogiri::HTML(open(base_path))
    scraped_pages = find_all(base_path, base_doc)
    {
	'inputs' => scraped_pages['inputs'].map {|input| parse(input)},
	'outputs' => scraped_pages['outputs'].map{|output| parse(output)}
    }
end
    
inputAndOutputs = go()
puts inputAndOutputs.to_yaml
