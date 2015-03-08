var PreviewTicketsView = Backbone.View.extend({
  template: JST["templates/ticket_preview"],
  tagName: "tbody",

  render: function() {
    this.collection.forEach(function(ticket) {
      this.$el.append(this.template(ticket));
    }.bind(this));
  }
});