// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
const $ = require("jquery");

window.$ = $;
window.jQuery = $;

require("jquery-ui/ui/widgets/core");
require("jquery-ui/ui/widgets/mouse");
require("jquery-ui/ui/widgets/datepicker")
require("jquery-ui/ui/widgets/slider")

console.log('window.jQuery:', window.jQuery);
console.log('window.$:', window.$);
console.log("$.fn.jquery:", $.fn.jquery); 

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("bootstrap")
require("bootstrap/dist/css/bootstrap")
require("@popperjs/core")