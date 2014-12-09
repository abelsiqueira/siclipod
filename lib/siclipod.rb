require 'siclipod/version'

def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require_all 'siclipod'
require_all 'siclipod/commands'

module Siclipod
  class Interface
    @@homedir = ENV['HOME'] + '/.siclipod/'
    @@config = ".config"

    class << self

      def parse(args)
        self.initialize

        if args.length == 0
          self.usage
          return
        end
        cmd = args[0]
        args.shift
        if Command.subclasses.select { |scmd|
          if cmd == scmd.to_s.split('::')[-1].downcase
            scmd.process(args)
            true
          else
            false
          end
        }.empty?
          puts "ERROR: Unrecognized command: '#{cmd}'"
        end
      end

      def initialize
        `mkdir -p #{@@homedir}`
        create_config unless File.exist?(@@homedir+@@config)
      end

      def create_config
        write_config({"player"=>"smplayer"})
      end

      def write_config(config)
        File.open(@@homedir+@@config,'w').write(JSON.pretty_generate(config))
      end

      def get_config
        JSON[File.read(@@homedir+@@config)]
      end

      def usage
        puts "siclipod"
        puts "  Commands:"
        Command.subclasses.each { |cmd|
          puts "  - #{cmd.to_s.split('::')[-1].downcase}"
        }
      end

      def homedir
        @@homedir
      end

      def config
        @@config
      end

    end

  end
end
