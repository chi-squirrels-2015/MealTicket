var RestaurantsCollection = Backbone.Collection.extend({
  baseUrl: "/search_yelp?",
  model: Restaurant,

  initialize: function(query) {
    this.url = this.baseUrl + query;
  }
});