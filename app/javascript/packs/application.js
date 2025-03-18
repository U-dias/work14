// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import $ from "jquery";
window.$ = $;
window.jQuery = $;

import "jquery-ui/ui/widgets/mouse";
import "jquery-ui/ui/widgets/datepicker";
import "jquery-ui/ui/widgets/slider";

import "@rails/ujs";
import "turbolinks";
import "@rails/activestorage";
import "channels";

// Bootstrap のインポート（最後に配置）
import "bootstrap";
import "bootstrap/dist/css/bootstrap";

console.log("window.jQuery:", window.jQuery);
console.log("window.$:", window.$);
console.log("$.fn.jquery:", $.fn.jquery);
console.log("window.bootstrap:", window.bootstrap);
console.log("typeof bootstrap:", typeof bootstrap);
