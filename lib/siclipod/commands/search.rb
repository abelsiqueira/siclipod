module Siclipod
  module Commands
    class Search < Command

      class << self

        def process(args)
          if args.length < 2
            raise "ERROR: Too few argument for search"
          else
            search(args[0], args[1])
          end
        end

        def get_search(feed, key)
          Siclipod::Parse.get_feed_items(feed).select { |item|
            item['filename'].include?(key)
          }
        end
        
        def search(feed, key)
          get_search(feed, key).each { |item|
            puts "- Filename: #{item['filename']}"
            puts "  Title: #{item['title']}"
            puts "  URL: #{item['url']}"
          }
        end

      end

    end
  end
end
