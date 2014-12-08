require 'json'

module Siclipod
  class Parse < Command

    class << self

      def get_feeds
        `ls #{Siclipod::Interface.homedir}`
      end

      def get_feed_data(feed)
        JSON[File.read(Siclipod::Interface.homedir + feed + "/data")]
      end

      def get_feed_items(feed)
        file = Siclipod::Interface.homedir + feed
        raise "ERROR: no feed #{feed}" unless Dir.exists?(file)
        file += "/items"
        raise "ERROR: #{feed} uninitialized" unless File.exists?(file)
        JSON[File.read(file)]
      end

    end

  end
end
