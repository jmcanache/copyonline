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
	$('#new_order').submit(function() {
	  	$.blockUI({ message: '<i class="fa fa-spinner fa-pulse fa-2x blue" style="padding: 2%"></i> <h4>Espere mientras sus archivos se cargan.</h4>' });
	});

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
		$('#order_color, #order_hoja_extra_oficio').closest('label').fadeIn();
	});

	$('#order_servicio_reduccion, #order_servicio_ampliacion').click(function(){
		$('#order_color, #order_hoja_extra_oficio').removeAttr('checked').closest('label').fadeOut();
		$('#folder_amount_color').prop('disabled', 'disabled');
		if(! $('#order_hoja_oficio').is(':checked')){
			$('#order_hoja_carta').prop( "checked", true );
		}	
	});

	$('#order_servicio_copia').click(function(){
		$('#order_color').removeAttr('checked').closest('label').fadeOut();
		$('#folder_amount_color').prop('disabled', 'disabled');
		$('#order_hoja_extra_oficio').closest('label').fadeIn();
	});

	$('#order_color').click(function(){
		$(this).is( ":checked" )? $('#folder_amount_color').removeAttr('disabled') : $('#folder_amount_color').attr('disabled', 'disabled');
	});

	$('#order_blanco_negro').click(function(){
		$(this).is( ":checked" )? $('#folder_amount_blanco_negro').removeAttr('disabled') : $('#folder_amount_blanco_negro').attr('disabled', 'disabled');
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