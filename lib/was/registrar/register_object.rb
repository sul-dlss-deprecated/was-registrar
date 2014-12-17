module Was
  module Registrar
    class RegisterObject
      def initalize
        @prefix="druid"
      end
      
      
      def register_object_using_web_service params
        puts params
        
        begin
         response=RestClient.post(Rails.configuration.service_root,  params, :timeout => 60, :open_timeout => 60)
         code = response.code
         puts code
        rescue Exception=> e
          raise "Error in registring the object. "+e.message 
        end
        puts response.body
        druid = response.body
        if valid_druid?(druid)
          return druid
        else
          raise "Error in registring the object. Not valid druid returned "+druid 
        end
        return druid
        
      end
      
      # @return [Regexp] matches druid:aa111aa1111 or aa111aa1111
      def pattern
        /\A(?:druid:)?([a-z]{2})(\d{3})([a-z]{2})(\d{4})\z/
      end
      
      # @param [String] druid id
      # @return [Boolean] true if druid matches pattern; otherwise false
      def valid_druid?(druid)
        return druid =~ pattern ? true : false
      end
    end
  end
end
