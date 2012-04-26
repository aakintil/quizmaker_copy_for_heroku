$categories = ['ALL','INT','FTV','QT','REF','MA'];

function filterBy(category) {
  if( category == 'ALL' ) {
    showAllDivs();
  } else {
    hideAllDivs();
    showDiv(category);
  }
}

function hideAllDivs(){
  //loop through the array and hide each element by category
  for (i in $categories) {
    $('.' + $categories[i]).hide();
  }
}

function showAllDivs() {
  //loop through the array and show each element by category
  for(i in $categories) {
    $('.' + $categories[i]).show();
  }
}

function showDiv(category) {
  $('.' + category).show();
}
