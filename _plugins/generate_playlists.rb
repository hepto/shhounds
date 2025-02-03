module Jekyll
  class PlaylistGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data['stations'].each do |station|
        site.pages << Playlist.new(site, station)
      end
    end
  end

  class Playlist < Jekyll::Page
    def initialize(site, station)
      @site = site
      @dir  = "stations"
      @name = "#{station['station_name'].gsub(/\s+/, '_').gsub(/([a-z])([A-Z])/, '\1_\2').downcase}.m3u8"
      self.process(@name)

      self.data = {
        "layout" => "playlist",
        "station_url" => station['station_url']
      }

    end
  end
end
