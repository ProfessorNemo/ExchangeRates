import consumer from './consumer'

consumer.subscriptions.create("RateChannel", {
    connected() {
        console.log('connected');
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        console.log(data)
        data['rate_value']
    }
});