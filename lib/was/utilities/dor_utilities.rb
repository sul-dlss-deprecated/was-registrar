# frozen_string_literal: true

module Was
  module Utilities
    class DorUtilities
      def initialize(apos_string)
        @apos_string = apos_string
      end

      def get_collections_list
        apo_collection_list = []
        apos_list = get_apos_list
        apos_list.each do |apo|
          apo_info_json = read_apo_data apo
          next if apo_info_json.nil?

          collections_list = parse_collection_json(apo_info_json['collections'])
          apo_title = apo_info_json['adminpolicies'].first['title'].sub('Web Archive ', '')

          apo_record = { apo_druid: apo,
                         apo_title: apo_title,
                         apo_collection: collections_list }
          apo_collection_list.push(apo_record)
        end
        apo_collection_list
      end

      def get_items_list
        apo_item_list = []
        apos_list = get_apos_list
        apos_list.each do |apo|
          apo_info_json = read_apo_data apo
          next if apo_info_json.nil?

          items_list = parse_items_json(apo_info_json['items'])
          apo_title = apo_info_json['adminpolicies'].first['title'].sub('Web Archive ', '')

          apo_record = { apo_druid: apo,
                         apo_title: apo_title,
                         apo_items: items_list }
          apo_item_list.push(apo_record)
        end
        apo_item_list
      end

      private

      def read_apo_data(_apo)
        raise NotImplementedError, 'APO retrieval via dor_fetcher is no longer supported'
      end

      def parse_collection_json(collection_json)
        collections_list = []
        collection_json&.each do |collection|
          collection_title = if collection['title'].length > 30
                               "#{collection['title'][0..30]} ..."
                             else
                               collection['title']
                             end
          collections_list.push(title: collection_title, druid: collection['druid'])
        end
        collections_list
      end

      def parse_items_json(items_json)
        items_list = []
        items_json&.each do |item|
          items_list.push(title: item['title'], druid: item['druid'])
        end
        items_list
      end

      def get_apos_list
        apos_list = []
        apos_list = @apos_string.split(',') if @apos_string.present?
        apos_list
      end
    end
  end
end
