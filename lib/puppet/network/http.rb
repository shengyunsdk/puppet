# This module is used to handle puppet REST requests in puppetserver.
module Puppet::Network::HTTP
  HEADER_ENABLE_PROFILING = "X-Puppet-Profiling"
  HEADER_PUPPET_VERSION = "X-Puppet-Version"

  MASTER_URL_PREFIX = "/puppet"
  MASTER_URL_VERSIONS = "v3"

  CA_URL_PREFIX = "/puppet-ca"
  CA_URL_VERSIONS = "v1"

  require 'puppet/network/authorization'
  require 'puppet/network/http/issues'
  require 'puppet/network/http/error'
  require 'puppet/network/http/route'
  require 'puppet/network/http/api'
  require 'puppet/network/http/api/master'
  require 'puppet/network/http/api/master/v3'
  require 'puppet/network/http/handler'
  require 'puppet/network/http/response'
  require 'puppet/network/http/request'
  require 'puppet/network/http/memory_response'
end
