require 'open-uri'
require 'uglifier'

class Scale
  def initialize
    @file_urls    = []
    @total_weight = 0
  end

  # Accepts file URL or array of file URLs
  # Places file(s) on scale
  # Returns scale
  def add(raw_file_url)
    @file_urls << *raw_file_url
    self
  end

  # Returns weight (file size in bytes) of all files on scale
  def weigh
    @total_weight = 0
    @file_urls.each do |file_url|
      raw_file = download(file_url)
      compressed_file = compress(raw_file)
      @total_weight += compressed_file.size
    end
    @total_weight > 0 ? @total_weight : nil
  rescue => e
    Rails.logger.error("#{e} error occured weighing #{@file_urls.join(', ')}")
    nil
  end

private

  # Accepts URL of file to download
  # Returns downloaded file
  def download(url)
    open(url).read.force_encoding('utf-8')
  end

  # Accepts JS file
  # Returns compressed JS file
  def compress(file)
    Uglifier.compile(file)
  end
end
