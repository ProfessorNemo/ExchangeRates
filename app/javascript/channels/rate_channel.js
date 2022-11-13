import consumer from './consumer'

const RateChannel = consumer.subscriptions.create("RateChannel", {
    connected() {
        console.log('Connected to RateChannel')
    },

    disconnected() {
        console.log('Disonnected from RateChannel')
    },

    received(data) {
        console.log(data)
        data['rate_value']
    },

    speak: function() {
        return this.perform('speak', {
            rate_value: data['rate_value']
        })
    }
})

export default RateChannel;