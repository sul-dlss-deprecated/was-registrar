# frozen_string_literal: true

module Was
  module Registrar
    # Base class to register an object using dor-services-app
    class RegisterObject
      def initialize
        @prefix = 'druid'
      end

      # Registers object based on item record
      # @param [Hash] crawl_item_hash is a hash that represents the crawl item
      # @raise [Error] if there is a missing parameters
      # @return [String] the druid id as returned from the registering object
      def register(item_hash)
        register_params = convert_column_to_params(item_hash)
        raise "Missing required parameters #{register_params}" unless is_valid?(register_params)

        register_object_using_web_service register_params
      end

      # Registers the object using dor-services REST API
      # @param [Hash] params is hash representing the registration informatino
      # @raise [Error] if there is a network problem in registering the object
      # @raise [Error] if the returned value is not a valid druid
      # @return [String] druid_id is the DRUID id as retreived from registeration service
      def register_object_using_web_service(register_params)
        Rails.logger.debug "Registering an object with params #{register_params}"
        begin
          response = Dor::Services::Client.objects.register(params: register_params)
        rescue StandardError => e
          Rails.logger.error 'Error in registering the object. ' + e.message
          Honeybadger.notify(e)
          raise
        end

        druid = response[:pid]
        if valid_druid?(druid)
          return druid
        else
          raise 'Error in registering the object. Invalid druid returned ' + druid
        end
      end

      # @return [Regexp] matches druid:aa111aa1111 or aa111aa1111
      def pattern
        /\A(?:druid:)?([a-z]{2})(\d{3})([a-z]{2})(\d{4})\z/
      end

      # @param [String] druid id
      # @return [Boolean] true if druid matches pattern; otherwise false
      def valid_druid?(druid)
        druid.match?(pattern) ? true : false
      end

      # @return [Boolean] true if the required parameters exist
      def is_valid?(register_params)
        if  register_params[:source_id].present? &&
            register_params[:label].present? &&
            register_params[:collection].present? &&
            register_params[:admin_policy].present?
          return true
        end

        false
      end
    end
  end
end
