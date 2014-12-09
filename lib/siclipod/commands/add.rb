require 'open-uri'
require 'nokogiri'
require 'json'

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
          `mkdir -p #{feeddir}podcasts`

          Siclipod::Parse.write_feed_data(feeddir,{"title"=>feed_title, "url"=>feedname})

          Siclipod::Parse.write_feed_items(feeddir,page.css('item').map { |item|
            url=item.css('enclosure')[0]['url']
            filename=url[/([^\/]*$)/,1]
            downloaded = File.exist?(feeddir + "podcasts/#{filename}") ? true : false
            { "filename"=>filename, "title"=>item.css('title')[0].content,
              "url"=>url, "downloaded"=>downloaded, "marked"=>downloaded}
          })
        end

      end

    end
  end
end
