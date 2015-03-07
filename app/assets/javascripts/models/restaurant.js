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
    var attributes = {};
    attributes.name = response.hash.name;
    attributes.yelp_id = response.hash.id;
    attributes.display_phone = response.hash.display_phone; // might need to default to null, when no phone number is listed on yelp
    attributes.address = response.hash.location.display_address.join(" ");
    attributes.zipcode = response.hash.location.postal_code;
    attributes.cuisine = response.hash.categories[0][0];

    return attributes;
  }
});
