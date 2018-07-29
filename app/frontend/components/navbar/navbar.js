window.onscroll = function() {
  var nav = document.getElementById('nav');
  var navLinks = document.querySelectorAll('.nav-item');
  var navBrand = document.getElementById('navbar-brand');
  var navBrandText = document.getElementById('navbar-brand-text');
  // console.log(window.pageYOffset);
  if ( window.pageYOffset > 150 ) {
    nav.classList.add("scrolled");
    addBlack(navLinks);
    addOpacity(navBrand);
    addOpacity(navBrandText)
  } else {
    nav.classList.remove("scrolled");
    removeBlack(navLinks);
    removeOpacity(navBrand);
    removeOpacity(navBrandText);
  }
}

function addBlack(items) {
  items.forEach((item) => {
    item.classList.add("black");
  });
}

function removeBlack(items) {
  items.forEach((item) => {
    item.classList.remove("black");
  });
}

function addOpacity(item) {
  item.classList.add("add-opacity");
}

function removeOpacity(item) {
  item.classList.remove("add-opacity");
}
