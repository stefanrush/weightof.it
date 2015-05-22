require 'open-uri'
require 'uglifier'

class Scale
  def weigh(version)
    raw_file = download(version.raw_url)
    compressed_file = compress(raw_file)
    compressed_file.size
  end

private

  def download(url)
    open(url).read
  end

  def compress(file)
    Uglifier.compile(file)
  end
end
