#!/usr/local/bin/ruby -w

# $Id$

require 'blink'
require 'blink/fact'

module Blink
    class Function
        @@functions = Hash.new(nil)

        #---------------------------------------------------------------
        def Function.[](name)
            return @@functions[name]
        end
        #---------------------------------------------------------------

        #---------------------------------------------------------------
        def call(args)
            @code.call(args)
        end
        #---------------------------------------------------------------

        #---------------------------------------------------------------
        # we want a 'proc' item instead of a block, so that we can return
        # from it
        def initialize(name,code)
            @name = name
            @code = code

            @@functions[name] = self
        end
        #---------------------------------------------------------------
    end

    Function.new("fact", proc { |fact|
        require 'blink/fact'

        value = Fact[fact]
        Blink.debug("retrieved %s as %s" % [fact,value])
        value
    })

    Function.new("addfact", proc { |args|
        require 'blink/fact'
        #Blink.debug("running addfact")

        hash = nil
        if args.is_a?(Array)
            hash = Hash[*args]
        end
        name = nil
        if hash.has_key?("name")
            name = hash["name"]
            hash.delete("name")
        elsif hash.has_key?(:name)
            name = hash[:name]
            hash.delete(:name)
        else
            raise "Functions must have names"
        end
        #Blink.debug("adding fact %s" % name)
        newfact = Fact.add(name) { |fact|
            hash.each { |key,value|
                method = key + "="
                fact.send(method,value)
            }
        }

        #Blink.debug("got fact %s" % newfact)
    })
end
