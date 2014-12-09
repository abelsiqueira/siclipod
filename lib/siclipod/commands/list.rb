require 'json'

module Siclipod
  module Commands
    class List < Command

      class << self

        def process(args)
          if args.length == 0
            list_feeds
          else
            list_feed(args[0])
          end
        end

        def list_feeds
          Siclipod::Parse.get_feeds.map { |feed|
            Siclipod::Parse.get_feed_data(feed)
          }.each { |feed|
            puts "- Title: #{feed['title']}"
            puts "  URL: #{feed['url']}"
          }
        end

        def list_feed(feed)
          Siclipod::Parse.get_feed_items(feed).each { |item|
            puts "- Filename: #{item['filename']}"
            puts "  Title: #{item['title']}"
            puts "  URL: #{item['url']}"
            puts "  Downloaded: #{item['downloaded']}"
            puts "  Marked: #{item['marked']}"
          }
        end

      end

    end
  end
end
