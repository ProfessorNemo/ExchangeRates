import consumer from './consumer'

const RateChannel = consumer.subscriptions.create(
    'RateChannel', {
        connected(data) {
            console.log('Connected to RateChannel')
            console.log(this.element)
        },

        disconnected() {
            console.log('Disonnected from RateChannel')
            console.log(this.element)
        }

    })

export default RateChannel;
