var YelpSearchView = Backbone.View.extend({
  template: JST["templates/yelp_search"],

  events: {
    "submit #yelp-search": "searchYelp"
  },

  render: function() {
    this.$el.html(this.template());

    return this;
  },

  searchYelp: function(e) {
    e.preventDefault();
    var query = this.$el.find("#yelp-search").serialize();
    this.collection = new RestaurantsCollection(query);
    this.collection.fetch().success(function(response) {
      this.$el.find("#yelp-search").hide();

      if(response.length === 0) {
        var newRestaurantView = new NewRestaurantView({ model: new Restaurant() });
        newRestaurantView.render();
        this.$el.append(newRestaurantView.el);
      } else {
        this.$el.append(JST["templates/yelp_results"]({collection: this.collection}));
      }
      
    }.bind(this));
  }
});
