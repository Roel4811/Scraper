// import Rails from 'rails-ujs';
// import "./side-menu.scss";

// import 'jquery-nice-select';

// $(document).ready(function() {
//   document.getElementById("provider").addEventListener("change", submitForm);
//   document.getElementById("brand").addEventListener("change", submitForm);
//   submitForm();
// });

function submitForm() {
  var form = document.querySelector('form');
  Rails.fire(form, 'submit');
}

function initNiceSelect() {
  const selectBoxes = document.querySelectorAll(".custom-select")
  selectBoxes.forEach((select_box) => {
    select_box.niceSelect();
  });
}

// initNiceSelect();
// import 'jquery-nice-select/dist/css/nice-select.css';


// export { initNiceSelect };
