module Was
  module Registrar
    # This is the base class to register an object using dor-service-app
    class RegisterObject
      def initalize
        @prefix = 'druid'
      end

      # Registers object based on item record
      # @param [Hash] crawl_item_hash is a hash that represents the crawl item
      # @raise [Error] if there is a missing parameters
      # @return [String] the druid id as retruned from the registering object
      def register(item_hash)
        druid = nil
        register_params = convert_column_to_params(item_hash)
        if is_valid?(register_params)
          druid = register_object_using_web_service register_params
        else
          fail "Missing required parameters #{register_params}"
        end
        druid
      end

      # Registers the object using dor-service REST API
      # @param [Hash] params is hash representing the registration informatino
      # @raise [Error] if there is a network problem in registering the object
      # @raise [Error] if the returned value is not a valid druid
      # @return [String] druid_id is the DRUID id as retreived from registeration service
      def register_object_using_web_service(register_params)
        Rails.logger.debug "Registering an object with params #{register_params}"
        begin
          resource = RestClient::Resource.new(
            Rails.configuration.service_root, read_timeout: 300, open_timeout: 60
          )
          # we explicitly want text response so the body is only the druid
          # New Rails dor-services-app defaults to json; old Sinatra one defaulted to text
          response = resource.post(register_params, accept: :text)
          Rails.logger.debug response.inspect
          code = response.code
        rescue RestClient::Exception => e
          Rails.logger.error 'Error in registering the object. ' + e.message
          raise
        end

        druid = response.body
        if valid_druid?(druid)
          return druid
        else
          fail 'Error in registring the object. Not valid druid returned ' + druid
        end
      end

      # @return [Regexp] matches druid:aa111aa1111 or aa111aa1111
      def pattern
        /\A(?:druid:)?([a-z]{2})(\d{3})([a-z]{2})(\d{4})\z/
      end

      # @param [String] druid id
      # @return [Boolean] true if druid matches pattern; otherwise false
      def valid_druid?(druid)
        druid =~ pattern ? true : false
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
