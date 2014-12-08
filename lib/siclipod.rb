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

    end

  end
end
