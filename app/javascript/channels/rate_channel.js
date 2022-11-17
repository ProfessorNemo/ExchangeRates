import consumer from './consumer'

const RateChannel = consumer.subscriptions.create("RateChannel", {
    connected() {
        console.log('Connected to RateChannel')
    },

    disconnected() {
        console.log('Disonnected from RateChannel')
    },
})

export default RateChannel;