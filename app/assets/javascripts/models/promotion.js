var Promotion = Backbone.Model.extend({
  defaults: {
    groupSize: null,
    discount: null,
    minTotalSpend: null,
  },

  initialize: function(options) {
    this.groupSize = options.groupSize;
    this.discount = options.discount;
    this.minTotalSpend = options.minTotalSpend;
  }
})