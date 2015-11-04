/*

My Custom JS
============

Author:  Brad Hussey
Updated: August 2013
Notes:	 Hand coded for Udemy.com

*/

$(function() {
	
	$('#alertMe').click(function(e) {
		
		e.preventDefault();
		
		$('#successAlert').slideDown();
		
	});
	
	$('a.pop').click(function(e) {
		e.preventDefault();
	});
	
	$('a.pop').popover();
	
	$('[rel="tooltip"]').tooltip();
	
	
});

$(document).ready(function() {
  $.fn.editable.defaults.mode = 'inline';	
  $('[name^=editService]').editable({
  		validate: function(value) {
				if($.trim(value) == '') {
    			return 'Este campo es requerido';
			}	
		}
 	});
});