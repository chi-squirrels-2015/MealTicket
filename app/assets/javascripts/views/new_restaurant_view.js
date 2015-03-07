var NewRestaurantView = Backbone.View.extend({
  template: JST["templates/new_restaurant"],

  render: function() {
    this.$el.html(this.template(this.model.attributes));
  }
});