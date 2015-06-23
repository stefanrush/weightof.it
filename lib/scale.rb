require 'uglifier'
require 'zlib'

class Scale
  include HTTParty

  def initialize
    @file_urls    = []
    @total_weight = 0
  end

  # Accepts file URL or array of file URLs
  # Places file(s) on scale
  # Returns scale
  def add(raw_file_url)
    @file_urls.push *raw_file_url
    self
  end

  # Returns weight (file size in bytes) of all files on scale
  def weigh
    @minified_weight = 0
    @gzipped_weight  = 0

    @file_urls.each do |file_url|
      raw_file = download(file_url)
      
      minified_file     = minify(raw_file)
      @minified_weight += minified_file.size
      
      gzipped_file     = gzip(minified_file)
      @gzipped_weight += gzipped_file.size
    end

    if @minified_weight > 0
      [@minified_weight, @gzipped_weight]
    else
      nil
    end
  rescue => e
    Rails.logger.error("#{e} error occured weighing #{@file_urls.join(', ')}")
    nil
  end

private

  # Accepts URL of file to download
  # Returns downloaded file
  def download(url)
    self.class.get(url, headers: {
      'User-Agent' => 'stefanrush/weightof.it'
    }).force_encoding('utf-8')
  end

  # Accepts JS file
  # Returns minified JS file
  def minify(file)
    Uglifier.compile(file)
  end

  # Accepts JS file
  # Returns gzipped JS file
  def gzip(file)
    Zlib::Deflate.deflate(file)
  end
end
