function flash_alert_behavior() {
  $fadeDelay = 3000; // milliseconds
  
  $("div.alert-success").delay($fadeDelay).fadeOut();
  
  $("a.close").click(function( e ) {
	      var $this = $(this)
	        , selector = $this.attr('data-target')
	        , $parent

	      if (!selector) {
	        selector = $this.attr('href')
	        selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') //strip for ie7
	      }

	      $parent = $(selector)
	      $parent.trigger('close')

	      e && e.preventDefault()

	      $parent.length || ($parent = $this.hasClass('alert') ? $this : $this.parent())

	      $parent
	        .trigger('close')
	        .removeClass('in')

	      function removeElement() {
	        $parent
	          .trigger('closed')
	          .remove()
	      }

	      $.support.transition && $parent.hasClass('fade') ?
	        $parent.on($.support.transition.end, removeElement) :
	        removeElement()
	});
}