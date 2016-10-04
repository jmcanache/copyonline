$(document).ready(function(){
    
	//Homepage Slider
    var options = {
        nextButton: false,
        prevButton: false,
        pagination: true,
        animateStartingFrameIn: true,
        autoPlay: true,
        autoPlayDelay: 3000,
        preloader: true
    };
    
    var mySequence = $("#sequence").sequence(options).data("sequence");

    //Main menu Initialization
    mainMenu.init();

	//Products slider
	var produxtsSlider = $('.products-slider').bxSlider({
		slideWidth: $('.products-slider .shop-item').outerWidth()-20, //Gets slide width
		responsive: true,
		minSlides: 1,
		maxSlides: 4,
		slideMargin: 20,
		auto: true,
		autoHover: true,
		speed: 800,
		pager: true,
		controls: false
	});

	/*Text area en monstrar ordenes*/
	$('#envio_0').click(function(){
		$('#direccion').removeAttr('required');
	})
	$('#envio_1').click(function(){
		$('#direccion').prop('required', 'required');
	})
	/*Fin de text area en mostrar ordenes*/

	/*Bloquear UI para realizar procesos*/
	$('#new_order').submit(function(e) {
		e.preventDefault();
		$('#preorder-alert').modal('show');
	  	//$.blockUI({ message: '<i class="fa fa-spinner fa-pulse fa-2x blue" style="padding: 2%"></i> <h4>Espere mientras sus archivos se cargan.</h4>' });
		//var confirmacion = confirm("AVISO: Su pedido estará listo en 24 horas hábiles. Desea continuar con su pedido?");
	
	});

	$('#preorder-ok').on('click', function(){
		$.blockUI({ message: '<i class="fa fa-spinner fa-pulse fa-2x blue" style="padding: 2%"></i> <h4>Espere mientras sus archivos se cargan.</h4>' });
		$('#new_order').unbind('submit').submit();
	})

    $('.detalles').click(function() { 
        $.blockUI({ 
        	css: { 
	            border: 'none', 
	            backgroundColor: 'none', 
	            color: '#fff' 
	        },

	        message: '<i class="fa fa-spinner fa-pulse fa-4x" style="color: #4EB7B7;"></i>'
	    }); 
    });

    $('#dialog').on('shown.bs.modal', function(){
    	$.unblockUI();
    });


	/*Fin de Bloquear UI para realizar procesos*/

	//Borrar informacion de un form al retroceder en el navegador
	$(window).bind("pageshow", function() {
    	$('form').get(0).reset(); 
	});
	//Fin deborrar informacion de un form al retroceder en el navegador

	/*Editar inline*/
	$('[name^=editService]').editable({
  		validate: function(value) {
				if($.trim(value) == '') {
    			return 'Este campo es requerido';
			}	
		}
 	});
	/*Fin de Editar inline*/


	//Initialize popover
	$(".fa-question-circle").popover({'trigger':'hover'});
	

	$('button.close').click(function(){
		$(this).closest('.container').empty();
	});

	//Make Videos Responsive
	$(".video-wrapper").fitVids();

	//Initialize tooltips
	$('.show-tooltip').tooltip();

	//Habilitaciones al momento de crear una orden new.html.erb
	$('#order_servicio_impresion').click(function(){
		$('#order_color, #folder_pages').closest('label').fadeIn();
	});

	$('#order_servicio_reduccion, #order_servicio_ampliacion').click(function(){
		$('#folder_pages').attr('disabled', 'disabled').closest('label').fadeOut();
		$('#order_color').removeAttr('checked').closest('label').fadeOut();
		$('#folder_amount_color').prop('disabled', 'disabled');
		if(! $('#order_hoja_oficio').is(':checked')){
			$('#order_hoja_carta').prop( "checked", true );
		}	
	});

	$('#order_servicio_copia').click(function(){
		$('#folder_pages').attr('disabled', 'disabled').closest('label').fadeOut();
		$('#order_color').removeAttr('checked').closest('label').fadeOut();
		$('#folder_amount_color').prop('disabled', 'disabled');
	});

	$('#order_color').click(function(){
		$(this).is( ":checked" )? $('#folder_amount_color').removeAttr('disabled') : $('#folder_amount_color').attr('disabled', 'disabled');
		$(this).is( ":checked" )? $('#folder_pages').removeAttr('disabled') : $('#folder_pages').attr('disabled', 'disabled');
	});

	$('#order_blanco_negro').click(function(){
		$(this).is( ":checked" )? $('#folder_amount_blanco_negro').removeAttr('disabled') : $('#folder_amount_blanco_negro').attr('disabled', 'disabled');
	});

	$("input[name='order[servicio]'], input[name='order[hoja]'], #order_color, #order_blanco_negro, #folder_amount_blanco_negro, #folder_amount_color").on('change', function(){
		var servicio = $("input[name='order[servicio]']:checked").val().toLowerCase();
		var hoja = $("input[name='order[hoja]']:checked").val().toLowerCase();
		var checkNegro = $('#order_blanco_negro').is(':checked');
		var checkColor = $('#order_color').is(':checked');
		var cantidadNegro = $('#folder_amount_blanco_negro').val();
		var cantidadColor = $('#folder_amount_color').val();
		var totalN = 0;
		var totalC = 0;
		if(checkNegro || checkColor){
			if(checkNegro){
				var totalN = $('#' + servicio + '_' + hoja + '_blanco_negro').val() * cantidadNegro;
			}
			if(checkColor){
				var totalC = $('#' + servicio + '_' + hoja + '_color').val() * cantidadColor;	
			}
			var total = totalN + totalC;
			$('#current-price').html('<p><span>Total: ' + total + 'BsF</span></p>');
		}else{
			$('#current-price').html('<p><span>Total: 0BsF</span></p>').fadeIn(1200);
		}

	});
	
  	$(document).on('change', '.btn-file :file', function() {
	  	var input = $(this),
	    numFiles = input.get(0).files ? input.get(0).files.length : 1,
	    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');

	    var texto = $(this).parents('.input-group').find(':text'),
	    log = numFiles > 1 ? numFiles + ' Archivos seleccionados' : label;

	    if( texto.length ) {
            texto.val(log);
        } else {
            if( log ) alert(log);
        }
	});

	//validacion de coincidencia entre input a color y numero de paginas
	$('#folder_pages, #folder_amount_color').blur(function(){
		var individual_pages =  $('#folder_pages').closest('label');
		var total_pages = $('#folder_amount_color').closest('label');
		numbers = $('#folder_pages').val().trim();

		if (! isPagesNumberValid(numbers) ){
			if(!($('#help-page').length)){
				$('#submitOrder').attr('disabled', 'disabled');
				individual_pages.addClass('has-error').append("<span id='help-page' class='help-block'>Error de formato.</span>");
			}
		}else{
			if(($('#help-page').length)){
				$('#submitOrder').removeAttr('disabled');
				individual_pages.removeClass('has-error');
				$('#help-page').remove();
			}

			if($('#folder_pages').val() != "" && $('#folder_amount_color').val() != ""){
				var pages_array = $('#folder_pages').val().split('-');
				var clean_array = pages_array.filter(function(e){ return e.replace(/(\r\n|\n|\r)/gm,"")});
				if($('#folder_amount_color').val() != clean_array.length.toString()){
					individual_pages.addClass('has-error');
					if(!($('.help-page').length)){
						$('#submitOrder').attr('disabled', 'disabled');
						total_pages.addClass('has-error').append("<span class='help-block help-page'>Cantidad no coincide.</span>");
						individual_pages.append("<span class='help-block help-page'>Cantidad no coincide.</span>");
					}
				}else{
					$('#submitOrder').removeAttr('disabled');
					total_pages.removeClass('has-error');
					individual_pages.removeClass('has-error');
					$('.help-page').remove();
				}
			}else{
				$('#submitOrder').removeAttr('disabled');
				total_pages.removeClass('has-error');
				individual_pages.removeClass('has-error');
				$('.help-page').remove();
			}
		}
	});

	function isPagesNumberValid(numbers) {
	    var pattern = /^[0-9]{1,5}( *- *[0-9]{1,5})*$/;
	    return numbers.length == 0 ? true : pattern.test(numbers);
	};

	//Fin de habilitaciones al momento de crear una orden new.html.erb

	// //Contact Us Map
	// if($('#contact-us-map').length > 0){ //Checks if there is a map element
	// 	var map = L.map('contact-us-map', {
	// 		center: [8.266815, -62.783140],
	// 		scrollWheelZoom: false,
	// 		zoom: 15
	// 	});
	// 	L.tileLayer('http://{s}.tile.cloudmade.com/{key}/22677/256/{z}/{x}/{y}.png', {
	// 		key: 'BC9A493B41014CAABB98F0471D759707'
	// 	}).addTo(map);
	// 	L.marker([8.266815, -62.783140]).addTo(map).bindPopup("<b>CopyOnline 21</b><br/>123 Fake Street<br/>LN1 2ST<br/>Guayana</br>Venezuela").openPopup();
	// }

	function init_map() {

		var var_location = new google.maps.LatLng(8.266815,-62.783140);
 
        var var_mapoptions = {
          center: var_location,
          zoom: 15
        };
 
		var var_marker = new google.maps.Marker({
			position: var_location,
			map: var_map,
			title:"Venice"});
 
        var var_map = new google.maps.Map(document.getElementById("contact-us-map"),
            var_mapoptions);
 
		var_marker.setMap(var_map);	
 
      }

	$( window ).resize(function() {
		$('.col-footer:eq(0), .col-footer:eq(1)').css('height', '');
		var footerColHeight = Math.max($('.col-footer:eq(0)').height(), $('.col-footer:eq(1)').height()) + 'px';
		$('.col-footer:eq(0), .col-footer:eq(1)').css('height', footerColHeight);
	});
	$( window ).resize();

	google.maps.event.addDomListener(window, 'load', init_map);

	//AJAX para obtener iformacion de cantidad de envios
	$( "body" ).delegate( ".EnvioDom", "change", function(){
		var id = $(this).val();
		var checked = $(this);
		var currentPages = parseInt($('#sumPages').val());
	    $.ajax({
	    	type: 'POST', 
	    	url: '/orders/envio',
	    	dataType: 'json',
	    	data: {"id": id}, 
	    	async: true,
	    	cache: false,
	    	success: function (d) {
	    		checked.is(':checked') ? currentPages+=d : currentPages-=d;
	    		$('#sumPages').val(currentPages);
    			if(currentPages >= 100){
    				$('#envioSi').fadeIn();
	    		}else{
    				$('#envioSi').fadeOut();
    				$('#envio_0').prop('checked', true);
	    		}
		 	}
	  	})
	})

    //conmutacion entre N/J en el registro de nuevos usuarios
    $('#user_jn').change(function(){
    	$( "select option:selected" ).val() == "0" ?  $('#user_cedula').attr('placeholder', 'Cédula') : $('#user_cedula').attr('placeholder', 'Rif');
    });
});

function resetActive(event, step) {

    $("div").each(function () {
        if ($(this).hasClass("activestep")) {
            $(this).removeClass("activestep");
        }
    });

    if (event.target.className == "col-md-2") {
        $(event.target).addClass("activestep");
    }
    else {
        $(event.target.parentNode).addClass("activestep");
    }

    hideSteps();
    showCurrentStepInfo(step);
}

function hideSteps() {
    $("div").each(function () {
        if ($(this).hasClass("activeStepInfo")) {
            $(this).removeClass("activeStepInfo");
            $(this).addClass("hiddenStepInfo");
        }
    });
}

function showCurrentStepInfo(step) {        
    var id = "#" + step;
    $(id).addClass("activeStepInfo");
}

setInterval(function getCountOrder(){
	//AJAX para obtener iformacion de cantidad de envio
    $.ajax({
    	type: 'GET', 
    	url: '/payments/count_new_orders',
    	dataType: 'json',
    	async: true,
    	cache: false,
    	success: function (d) {
    		var data = d;
    		if (data > 0) { 
    			$('#dropDownMenu').addClass('notification');
    			$('.notification').attr('data-count', d);
    		}
	 	}
  	})
}, 1000 * 60 * 3);