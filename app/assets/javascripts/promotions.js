$(function(){
  $('#group_size_slider').slider({
  	range: true,
  	min: 1,
  	max: 20,
  	values: [2,10],
  	slide: function(event, ui) {
  		$("#min_group_size").val( ui.values[0]);
      $("#max_group_size").val( ui.values[1]);
  	}
  });
  
  $("#min_group_size").val($("#group_size_slider").slider("values", 0));
  $("#max_group_size").val($("#group_size_slider").slider("values", 1));
});


$(function(){
  $('#pref_group_size_slider').slider({
  	range: "max",
  	min: 1,
  	max: 20,
  	value: 4,
  	slide: function( event, ui ){
  		$("#preferred_group_size").val(ui.value);
  	}
  });
  $("#preferred_group_size").val( $( "#pref_group_size_slider").slider( "value" ) );

});

$(function(){
  $('#loss_slider').slider({
  	range: "max",
  	min: 100,
  	max: 1000,
  	value: 200,
  	slide: function( event, ui ){
  		$("#loss_tolerance").val(ui.value);
  	}
  });
  $("#loss_tolerance").val( $( "#loss_slider").slider( "value" ) );

});

$(function(){
  $('#min_spend_slider').slider({
  	range: "max",
  	min: 10,
  	max: 25,
  	value: 15,
  	slide: function( event, ui ){
  		$("#min_spend").val(ui.value);
  	}
  });
  $("#min_spend").val( $( "#min_spend_slider").slider( "value" ) );
});

$(function(){
  $('#max_disc_slider').slider({
  	range: "max",
  	min: 10,
  	max: 100,
  	value: 20,
  	slide: function( event, ui ){
  		$("#max_discount").val(ui.value);
  	}
  });

  $("#max_discount").val( $( "#max_disc_slider").slider("value") );
});
