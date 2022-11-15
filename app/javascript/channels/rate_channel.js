import consumer from './consumer'

const counterChannel = consumer.subscriptions.create("RateChannel", {
    connected() {
        console.log('Connected to RateChannel')
    },

    disconnected() {
        console.log('Disonnected from RateChannel')
    },
})

export default counterChannel;