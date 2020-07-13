paceOptions = {
  elements: true,
  target: '.page-loader'
};

$(window).load(function(){
	$('.page-loader').fadeOut('slow',function(){$(this).remove();});
});