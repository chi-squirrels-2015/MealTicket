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
    return {
      name: response.hash.name,
      yelp_id: response.hash.id,
      display_phone: response.hash.display_phone,
      address: response.hash.location.display_address.join(" "),
      zipcode: response.hash.location.postal_code,
      cuisine: response.hash.categories[0][0]
    }
  }
});
