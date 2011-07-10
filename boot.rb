#require 'rubygems'
require 'bundler/setup'
Bundler.require(:default) if defined?(Bundler)

require File.expand_path('../config', __FILE__)

#allowed pagination
module Instagram
	module Pagination
		def get(path, options={}, raw=false, unformatted=false)
			response = request(:get, path, options, raw, unformatted)
			@pagination = response.pagination unless response.pagination.nil?
			response
		end

		def pagination
			@pagination
		end

		def next_cursor
			@pagination.next_cursor.to_i
		end

		def next_url
			@pagination.next_url
		end
	end

	class Client
		include Instagram::Pagination
	end
end

