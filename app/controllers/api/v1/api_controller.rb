module Api
  module V1
    class ApiController < ApplicationController
      
      respond_to :json
      
      before_filter :check_format
      
      after_filter :set_access_control_headers
      
      skip_before_filter :authenticate_user
      
      skip_before_filter :verify_authenticity_token
      
      layout("api_layout.json")
      
      def options
        head :ok
        #render :nothing => true, :status => 200
      end
      
      def security_params
        params.require(:token)
      end
      
      # allows the cross origin POST requests made by mobile app
      def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        #headers['Access-Control-Expose-Headers'] = 'ETag'
        headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
        headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
        #headers['Access-Control-Max-Age'] = '86400'
      end
                     
      def check_format
          render :nothing => true, :status => 406 unless params[:format] == 'json'
      end  
           
      def render404
        #puts "*** 404 Error code triggered from API controller (pat)"
        respond_error("Invalid URL")
      end

      def respond_via_rabl(msg="Action Worked.")
        # see the associated rabl file in the view which gets its 
        # information from specific @variables (like msg)
        @msg = msg
      end

      def respond_result(result, msg="Action Worked.")
        # used for simple returns not needing complex rabl
        render json: { success: true, messages: [msg], result: result }
      end
      
      def respond_error(messages=["Processing Error"])
        render json: { success: false, messages: messages, result: nil }
      end
      
    end
    
  end
end

