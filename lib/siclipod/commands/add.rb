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
            puts "ERROR fetching #{feedname}"
          end
          begin
            page = Nokogiri::HTML(html)
          rescue
            puts "ERROR parsing"
          end

          feeddir = Siclipod::Interface.homedir + feedname + '/'
          `mkdir -p #{feeddir}`
          orig = page.css('channel').css('title')[0].content
          File.open(feeddir + 'items') { |file|
            page.css('item').each { |item|
              title = item.css('title')[0].content
              url = item.css('enclosure')[0]['url']
              file.write [title,url]
            }
          }
        end

      end

    end
  end
end
