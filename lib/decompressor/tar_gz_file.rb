require 'rubygems/package'
require 'zlib'

module Decompressor
  class TarGzFile
    def self.call(archive, only_file)
      archive        = StringIO.new(archive) if !archive.respond_to?(:read)
      tar            = Zlib::GzipReader.new(archive)
      tar_extract    = Gem::Package::TarReader.new(tar)
      only_file      = tar_extract.find { |entry| entry.full_name.ends_with?(only_file) }
      only_file_data = only_file.read
      tar.close
      tar_extract.close
      only_file_data
    end
  end
end
