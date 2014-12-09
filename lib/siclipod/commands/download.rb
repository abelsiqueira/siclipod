module Siclipod
  module Commands
    class Download < Command

      class << self

        def process(args)
          if args.length < 2
            raise "ERROR: Too few argument for download"
          else
            download(args[0], args[1])
          end
        end

        def download(feed, key)
          list = Siclipod::Commands::Search.get_search(feed, key)
          if list.length == 0
            raise "ERROR: No match for #{key} in filenames of feed #{feed}"
          end
          list.each_with_index { |item,i|
            n = i.to_s.rjust(3,'0')
            puts "[#{n}] Filename: #{item['filename']}"
            puts "      Title: #{item['title']}"
            puts "      URL: #{item['url']}"
          }
          print "Which file to download: "
          n = Integer($stdin.gets.chomp)
          if n < 0 or n >= list.length
            raise "ERROR: index out of range"
          end
          download_file(feed, list[n]['url'], list[n]['filename'])
        end

        def download_file(dir, url, filename)
          dir = Siclipod::Interface.homedir + dir + '/podcasts'
          puts "Downloading #{url} to #{dir}"
          `wget #{url} -t 0 -O #{dir}/#{filename}`
        end

      end

    end
  end
end
