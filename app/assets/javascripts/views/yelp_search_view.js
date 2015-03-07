var YelpSearchView = Backbone.View.extend({
  template: JST["templates/yelp_search"],

  events: {
    "submit #yelp": "searchYelp"
  },

  render: function() {
    this.$el.html(this.template());

    return this;
  },

  searchYelp: function(e) {
    e.preventDefault();
    var query = this.$el.find("#yelp").serialize();
    this.collection = new RestaurantsCollection(query);
    this.collection.fetch().success(function(response) {
      this.$el.hide();
      this.$el.html(JST["templates/yelp_results"]({collection: this.collection}));
      this.$el.show();
    }.bind(this));
  }
});