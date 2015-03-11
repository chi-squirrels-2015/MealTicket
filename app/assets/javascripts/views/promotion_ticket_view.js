var PromotionTicket = Backbone.View.extend({
  template: JST["templates/promotion_tickets"],

  render: function() {
    this.$el.html(this.template(this.model.attributes));
  }
});