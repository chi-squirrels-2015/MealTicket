var Restaurant = Backbone.Model.extend({
  defaults: {
    yelp_id: null,
    name: null,
    display_phone: null,
    address: null,
    zipcode: null,
    cuisine: null
  },

  parse: function(response) {
  }
});
