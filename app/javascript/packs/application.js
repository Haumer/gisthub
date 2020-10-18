// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  let labels = Array.from(document.querySelectorAll(".group-info .group"))
  function invertColor(element) {
    let color = element.dataset.color
    element.style.color = invert(color, true)
    element.style.borderColor = invert(color, true)
  }
  labels.forEach(invertColor)

  let gists = document.querySelectorAll(".gist-data")
  gists.forEach((gist) => {
    gist.classList.add("small-gist")
  })
});

import {search, filter} from './groupSearch.js'
import invert from 'invert-color';
import "controllers"

// let cards = document.querySelectorAll(".gist-card")
// Array.from(cards).forEach(card => {
//   let option = card.querySelector(".options")
//   let modal = document.querySelectorAll(".gist-options")
//   modal.id = `Gist${card.dataset.gist}`

//   card.addEventListener("click", () => {
//     console.log(modal.id)
//   })
// })





