require 'rexml/document'
require 'yaml'

module Github
  class Feed
    attr_reader :entries
    def initialize
      @feed_content = yield if block_given?
      @entries = {}
      @e_order = []
    end
## Interface functions ##
    def [](index)
      @entries[@e_order[index]]
    end

    def length
      @e_order.length
    end

## Feed Parsing Functions ##

    # parses loaded feed contents into list of hashes
    # which are stores in memory cache (@entries)
    # order is preserved by @e_order array
    def parse
      #puts @feed_content
      doc = REXML::Document.new(@feed_content)
      entries = [].tap do | collection |
        doc.root.elements.select { |e| e.name =~ /entry/ }.each do | el |
          collection << el
        end
      end
      entries.each do | entry |
        id = get_data_from_element(entry, 'id')
        unless @entries.key? id
          @entries[id] ||= parse_entry(id, entry)
          @e_order << id
        end
      end
    end

    # Parses one feed element into a entry containing all needed information
    # id must be retreived beforehand because of caching
    def parse_entry id, entry
      {
        :id => id,
        :content => get_data_from_element(entry, 'content'),
        :title => get_data_from_element(entry, 'title'),
        :link => get_data_from_element(entry, 'link', :attribute, 'href'),
        :author => get_author(entry),
        :published => get_data_from_element(entry, 'published')
      }
    end


  private
    def get_data_from_element(element, name, func=:get_text, extra_param=nil)
      r=""
      element.elements.select {  | el | el.name =~ /#{name}/ }.each do | tag |
        # get_text doesn't require params, attribute does
        # probably this code should be clever and assume multiple attrs (which kinda does
        # through *operator)
        r = extra_param.nil? ? tag.send(func) : tag.send(func, extra_param)
      end
      "#{r}" # cast tag data to a string, so that we don't have REXML garbage
    end
    def get_author(entry)
      au = entry.elements.select { | el | el.name =~ /author/ }.map do | auth |
        {
          :name => get_data_from_element(auth, 'name'),
          :url => get_data_from_element(auth, 'uri')
        }
      end
    end
  end
end
