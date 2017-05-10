$(document).on('turbolinks:load',function() {

  'use strict';

  // define variables
  var items = document.querySelectorAll(".timeline li");

  // check if an element is in viewport
  // http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
  function isElementInViewport(el) {
    var rect = el.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (document.getElementById("scrollDiv").innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (document.getElementById("scrollDiv").innerWidth || document.documentElement.clientWidth)
    );
  }

  function callbackFunc() {
    for (var i = 0; i < items.length; i++) {
      if (isElementInViewport(items[i])) {
        items[i].classList.add("in-view");
      }
    }
  }

  // listen for events
  document.getElementById("scrollDiv").addEventListener("load", callbackFunc);
  document.getElementById("scrollDiv").addEventListener("resize", callbackFunc);
  document.getElementById("scrollDiv").addEventListener("scroll", callbackFunc);

})
