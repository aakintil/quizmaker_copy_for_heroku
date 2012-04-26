// Sort the boxes by the thing that got clicked

function box_sort() {

  // When a sorting key is clicked
  $("div.event-key").click(function(){
    $key = $(this);
    if($key.hasClass('selected')) {
      $key.removeClass('selected');
    } else {
      $key.addClass("selected");
      sort_boxes('.ev-title');
    }
  });
  
}

function sort_boxes(key) {
  $hash = {};
  $boxes = $(".event-box");
  // $elements = $boxes.each(function() {
  //   $title = $($(this).find(key)).html();
  //   console.log("Title: " + $title);
  //   $hash[$title] = $(this);
  // });
  
  $elements = $boxes.map(function() { 
    $title = $($(this).find(key)).html(); 
    $hash[$title] = $(this); 
    return $title; 
  });
  $sortedElems = $elements.sort();
  $sortedBoxes = [];
  for(e in $sortedElems) {
    $sortedBoxes.push($hash[e]);
  }
  $newHTML = "";
  for(b in $sortedBoxes) {
    $newHTML.concat($(b).html());
  }
  $('.events').html($newHTML);
}

function check_classes() {
  $("a.sort-key").each(function(){
    alert('hey');
    if( $(this).hasClass('selected-asc') ) {
      $(this).append('<span class="arrow"> &#x25B2;</span>');
    } else if( $(this).hasClass('selected-desc') ) {
      $(this).append('<span class="arrow"> &#x25BC;</span>');
    } else {
      $(this).find('span.arrow').remove();
    }
  });
}

function clear_all_sorts(){
  $("a.sort-key").each(function(){
    $(this).removeClass('selected-asc');
    $(this).removeClass('selected-desc');
  });
}