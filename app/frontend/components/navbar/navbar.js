window.onscroll = function() {
  var nav = document.getElementById('nav');
  if ( window.pageYOffset > 100 ) {
      nav.classList.add("scrolled");
  } else {
      nav.classList.remove("scrolled");
  }
}
