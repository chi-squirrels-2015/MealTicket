var Restaurant = Backbone.Model.extend({
  parse: function(response) {
    var attributes = {};
    attributes.name = response.hash.name;
    attributes.yelp_id = response.hash.id;
    attributes.display_phone = response.hash.display_phone;
    attributes.address = response.hash.location.display_address.join(" ");
    attributes.zipcode = response.hash.location.postal_code;
    attributes.cuisine = response.hash.categories[0][0];

    return attributes;
  }
});