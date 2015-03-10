var Ticket = Backbone.Model.extend({
  defaults: {
    groupSize: null,
    discount: null,
    minTotalSpend: null,
  },

  parse: function(data) {
    this.groupSize = data.group_size;
    this.discount = (parseFloat(data.discount) * 100).toFixed(2) + "%";
    this.minTotalSpend = "$" + parseFloat(data.min_total_spend).toFixed(2);
  }
});