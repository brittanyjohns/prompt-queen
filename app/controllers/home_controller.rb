class HomeController < ApplicationController
  def index
  end

  def site_parser
    puts "SITE PARSER\n#{params.inspect}"
    # doc = params["site_parser"]["doc"]
    # puts "\ndoc: #{doc.original_filename}\n"
    path = "storage/md/40/md4001wfpkz9bqrkdbva76id0gro"
    site_parser = SiteParser.new(path)
    result = site_parser.call
    puts "RESULT: #{result.inspect}"
  end
end
