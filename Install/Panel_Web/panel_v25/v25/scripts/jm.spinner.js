(function($){

	$.fn.jmspinner = function(value){
		var small = 'small';
		var custom = 'custom';
		var large = 'large';
		var div_bounces ='';
		var div  = document.createElement('div');
		var plc = $(div).prop('class', 'spin_loading');
		var inner = document.createElement('div');
		var center_loading = $(inner).prop('class', 'spinner');
		var made = $(plc).html(center_loading);
		var bce1 = document.createElement('div');
		var bce2 = document.createElement('div');
		var bce3 = document.createElement('div');
		var div_btn_1 = $(bce1).prop('class', 'bounce1');
		var div_btn_2 = $(bce2).prop('class', 'bounce2');
		var div_btn_3 = $(bce3).prop('class', 'bounce3');
		// returning the bounce divs to the template

		//var div_inner_bounces = $(div_bounces).html(div_btn);
		var divs_bts;
		var index = 0;
		var loading =  [];
		loading.push(div_btn_1,div_btn_2, div_btn_3);


		$.each(loading, function(i, index){

			divs_bts = $(center_loading).append(index);

		});
		
		if(value == 'small'){
			var small = $(divs_bts).addClass('small');
			 this.html(small);
			 return this;
		}
		if(value == 'large'){
			var large = $(divs_bts).addClass('large');
			 this.html(large);
			 return this;
		}
		if(value == null){
			var detf = $(divs_bts).addClass('default');
			 this.html(detf);
			 return this;
		}

		if(value == false){
			 this.find('.spinner').remove();
			 return this;
		}


	}


}(jQuery));