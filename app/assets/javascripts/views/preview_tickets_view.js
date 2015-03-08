var PreviewTicketsView = Backbone.View.extend({
  template: JST["templates/tickets_preview"],

  render: function() {
    this.$el.html(this.template());
  },

  addAll: function() {
    this.collection.forEach(function(ticket) {
      var ticketView = new PreviewTicketView({model: ticket})
      ticketView.render();
      this.$el.find("tbody").append(ticketView.el)
    }.bind(this));
  }
});