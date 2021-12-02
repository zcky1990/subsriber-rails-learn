require 'bunny'

module MessagePublisher
    def self.publish_event(channel_name, body_params)
        connection = Bunny.new(
            host: '172.18.0.1',
            port: 5672,
            vhost: '/',
            user: 'guest',
            password: 'guest')
        connection.start

        channel = connection.create_channel
        queue = channel.queue(channel_name)

        channel.default_exchange.publish(body_params.to_json, routing_key: queue.name)
        puts " [x] Sent 'Hello World! via #{channel_name}'"
    end

    def self.subsrice_event
        connection = Bunny.new(
            host: '172.18.0.1',
            port: 5672,
            vhost: '/',
            user: 'guest',
            password: 'guest',
            automatically_recover: false)
        connection.start

        channel = connection.create_channel
        queue = channel.queue('hello')

        begin
            puts ' [*] Waiting for messages. To exit press CTRL+C'
            # block: true is only used to keep the main thread
            # alive. Please avoid using it in real world applications.
            queue.subscribe(block: true) do |_delivery_info, _properties, body|
                puts " [x] Received #{body}"
            end
            rescue Interrupt => _
            connection.close
            exit(0)
        end
    end

end