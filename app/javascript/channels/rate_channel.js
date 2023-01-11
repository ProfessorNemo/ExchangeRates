import consumer from "./consumer"

consumer.subscriptions.create("RateChannel", {
  connected() {
    console.log("RateChannel connected");
  },

  disconnected() {
    console.log("RateChannel disconnected");
  },

  received(data) {
    console.log(`RateChannel received data: ${data.content}`);
    $('#exchange_rate').html(data.content);
  }
});
