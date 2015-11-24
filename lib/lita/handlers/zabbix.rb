module Lita
  module Handlers
    class Zabbix < Handler
      # Handler Receives a POST over a certain URL context
      # Then performs the action, :zabbix_alert
      http.post '/zabbix-alert', :zabbix_alert
      # HTTP handlers take a request and response arguments
      def zabbix_alert( request, response )
      	# Using the request parameters, Form Data, assign it to the
      	# response body. 
      	response.body << request.params["subject"]
      	#
      	robot = request.env["lita.robot"]
      	# Setup a Source to send to
      	source = Lita::Source.new(user: nil, room: '#csmops')
      	# Send the message to the Source using the Form Data sent.
      	robot.send_messages(source, request.params["subject"][0..256])
      end

      route(/^echo\s+(.+)/, :echo, help: { "echo TEXT" => "Echoes back TEXT." })
      def echo(response)
        response.reply(response.matches)
      end

      Lita.register_handler(self)
    end
  end
end
