// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// StimulusJS
// import { Application } from "stimulus"
// import { definitionsFromContext } from "stimulus/webpack-helpers"

// const application = Application.start()
// const context = require.context("controllers", true, /_controller\.js$/)
// application.load(definitionsFromContext(context))

// Internal imports:
import { search, filter } from './groupSearch.js';
import { invertColor } from './invertColor.js';
import { collapseGists } from './collapseGists.js';
import { expandGists } from './expandGists.js';
import { loadSpinner } from './spinner.js';
import { initTooltips } from './init_tooltips.js';

document.addEventListener('turbolinks:load', () => {
  collapseGists();
  loadSpinner();
  initTooltips();
  // expandGists()
});


