var Ticket = Backbone.Model.extend({
  defaults: {
    groupSize: null,
    discount: null,
    minTotalSpend: null
  },

  parse: function(data) {
    this.groupSize = data.group_size;
    this.discount = data.discount;
    this.minTotalSpend = data.min_total_spend;
  }
})