var PreviewTicketsCollection = Backbone.Collection.extend({
  baseUrl: "/preview_tickets?",
  model: Ticket,

  initialize: function(query) {
    this.url = this.baseUrl + query
  }
});
