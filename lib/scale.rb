require 'open-uri'
require 'uglifier'

class Scale
  def initialize(raw_file_url)
    @raw_file_url = raw_file_url
  end

  def weigh
    return nil unless @raw_file_url
    raw_file = download(@raw_file_url)
    return nil unless raw_file
    compressed_file = compress(raw_file)
    compressed_file.size
  end

private

  def download(url)
    open(url).read.force_encoding('utf-8') rescue nil
  end

  def compress(file)
    Uglifier.compile(file)
  end
end
