module Siclipod
  module Commands
    class Play < Command

      class << self

        def process(args)
          if args.length < 2
            raise "ERROR: Too few argument for download"
          else
            play(args[0], args[1])
          end
        end

        def play(feed, key)
          dir = Siclipod::Interface.homedir + feed + "/podcasts"
          dir = dir.gsub(' ','\ ')
          list = `ls #{dir}/*#{key}*`.split("\n")
          if list.length == 0
            raise "ERROR: No downloaded podcasts matching #{key} for #{feed}"
          end
          list.each_with_index { |item,i|
            n = i.to_s.rjust(3,'0')
            puts "[#{n}] #{item}"
          }
          print "Which file to play: "
          n = Integer($stdin.gets.chomp)
          if n < 0 or n >= list.length
            raise "ERROR: index out of range"
          end
          puts "Playing #{list[n]}"
          player = Siclipod::Interface.get_config["player"]
          puts `#{player} "#{list[n]}"`
        end

      end

    end
  end
end
