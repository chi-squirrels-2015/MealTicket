var YelpSearchView = Backbone.View.extend({
  this.template:  JST["templates/yelp_search"],

  events: {
    "submit #yelp": "searchYelp"
  },

  render: function() {
    this.$el.html(this.template());

    return this;
  },

  searchYelp: function(e) {
    e.preventDefault();

    var collection = new RestaurantsCollection($(this).serialize());
    collection.fetch();
    this.$.el.hide();
  }
});