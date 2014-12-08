require 'open-uri'
require 'nokogiri'

module Siclipod
  module Commands
    class Add < Command

      class << self

        def process(args)
          addfeed(args[0])
        end

        def addfeed(feedname)
          begin
            html = open(feedname)
          rescue
            throw "ERROR fetching #{feedname}"
          end
          begin
            page = Nokogiri::HTML(html)
          rescue
            throw "ERROR parsing"
          end


          feed_title = page.css('channel').css('title')[0].content
          feeddir = Siclipod::Interface.homedir + feed_title + '/'
          `mkdir -p #{feeddir}`

          File.open(feeddir + 'data','w') { |file|
            file.write("{'title': #{feed_title},\n")
            file.write(" 'url': #{feedname}}\n")
          }
          File.open(feeddir + 'items','w') { |file|
            page.css('item').each { |item|
              title = item.css('title')[0].content
              url = item.css('enclosure')[0]['url']
              file.write("[#{title},\n")
              file.write(" #{url}]\n")
            }
          }
        end

      end

    end
  end
end
