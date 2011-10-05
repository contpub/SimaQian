@Grab('com.rabbitmq:amqp-client:2.6.1')

import com.rabbitmq.client.*

factory = new ConnectionFactory()
factory.host = 'localhost'
connection = factory.newConnection()
channel = connection.createChannel()

channel.queueDeclare('msgs', false, false, false, null)

//Sending
/*
message = 'Hello, RabbitMQ!'
channel.basicPublish('', 'msgs', null, message.bytes)
println(" [x] Sent '$message'")
*/

//Receiving
consumer = new QueueingConsumer(channel)
channel.basicConsume('msgs', true, consumer)

while (true) {
	delivery = consumer.nextDelivery()
	message = new String(delivery.body)
	println(" [x] Received '$message'")
}

channel.close()
connection.close()
