module Jekyll
  class PlaylistGenerator < Jekyll::Generator
    safe true

    def generate(site)

      playlists = []

      site.data['stations'].each do |station|
        playlist = Playlist.new(site, station)
        site.pages << playlist
        playlists << { "station_name" => station['station_name'], "playlist_url" => playlist.url }
      end

       site.config['playlists'] = playlists

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
