// Enable google analytics with turbolinks
document.addEventListener("turbolinks:load", function(event) {
  console.log("g analytics");
  if (typeof ga === "function") {
    ga("set", "location", event.data.url);
    ga("send", "pageview");
  }
});
