import Rails from 'rails-ujs';
import "./side-menu.scss";

$(document).ready(function() {
  document.getElementById("provider").addEventListener("change", submitForm);
  document.getElementById("brand").addEventListener("change", submitForm);
  submitForm();
});

function submitForm() {
  var form = document.querySelector('form');
  Rails.fire(form, 'submit');
}
