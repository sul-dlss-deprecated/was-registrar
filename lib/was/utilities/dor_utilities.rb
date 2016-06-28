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
          apo_title = apo_info_json['adminpolicies'].first['title'].sub('Web Archive ','')

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
          apo_title = apo_info_json['adminpolicies'].first['title'].sub('Web Archive ','')

          apo_record = { apo_druid: apo,
                         apo_title: apo_title,
                         apo_items: items_list }
          apo_item_list.push(apo_record)
        end
        apo_item_list
      end

      private

      def read_apo_data(apo)
        begin
          resource = RestClient::Resource.new(
            Rails.configuration.apo_list_call, timeout: 60, open_timeout: 60
          )
          response = resource[apo].get
          Rails.logger.debug response.inspect
          return JSON.parse(response.body)
        rescue RestClient::Exception => e
          Rails.logger.fatal 'Error in reading apo list: ' + e.inspect
          Rails.logger.fatal e.backtrace.join("\n") if e.backtrace.present?
          raise
        end
        nil
      end

      def parse_collection_json(collection_json)
        collections_list = []
        unless collection_json.nil?
          collection_json.each do |collection|
            if collection['title'].length > 30 then
              collection_title = "#{collection['title'][0..30]} ..."
            else
              collection_title = collection['title']
            end
            collections_list.push(title: collection_title, druid: collection['druid'])
          end
        end
        collections_list
      end

      def parse_items_json(items_json)
        items_list = []
        unless items_json.nil?
          items_json.each do |item|
            items_list.push(title: item['title'], druid: item['druid'])
          end
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
