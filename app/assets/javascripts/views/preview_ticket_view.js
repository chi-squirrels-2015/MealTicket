var PreviewTicketView = Backbone.View.extend({
  template: JST["templates/ticket_preview"],
  tagName: "tr",

  render: function() {
    this.$el.html(this.template(this.model));
  }
})