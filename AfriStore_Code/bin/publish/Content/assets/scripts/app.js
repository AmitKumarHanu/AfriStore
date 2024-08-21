var dropdown = document.getElementsByClassName('emov-a-sidebar-dropdown-btn');
var i;

for (i = 0; i < dropdown.length; i++) {
   dropdown[i].addEventListener('click', function () {
      this.classList.toggle('emov-a-sidebar-dropdown-active');
      var dropdownContent = this.nextElementSibling;
      if (dropdownContent.style.display === 'flex') {
         dropdownContent.style.display = 'none';
      } else {
          dropdownContent.style.display = 'flex';
          document.querySelector(".appointment").classList.add("emov-a-menu-item-active");
          document.querySelector("#dashboard").classList.remove("emov-a-menu-item-active");
          document.querySelector(".applications").classList.remove("emov-a-menu-item-active");
          document.querySelector(".reports").classList.remove("emov-a-menu-item-active");
          document.querySelector(".admin-module").classList.remove("emov-a-menu-item-active");
          document.querySelector(".users").classList.remove("emov-a-menu-item-active");
          document.querySelector(".slots").classList.remove("emov-a-menu-item-active");
      }
   });
}

var menu_btn = document.getElementById('menu_toogle');
var sidebar = document.getElementById('emov_sidebar');
var overlay = document.getElementById('emov-overlay-menu');
var body = document.getElementsByTagName('body')[0];
var html = document.getElementsByTagName('html')[0];

menu_btn.addEventListener('click', (e) => {
    e.preventDefault();
    showmenu();
});

overlay.addEventListener('click', (e) => {
    showmenu();
    overlay.style.display = 'none';
});

function showmenu() {
    if (sidebar.style.display == 'none') {
        sidebar.classList.toggle('emov-sidebar-open');
        body.classList.toggle('emov-hook');
        html.classList.toggle('emov-hook');
        overlay.classList.toggle('show');
    } else {
        sidebar.classList.toggle('emov-sidebar-open');
        body.classList.toggle('emov-hook');
        html.classList.toggle('emov-hook');
        overlay.style.display = 'block';
        overlay.classList.toggle('show');
    }
}



//function myFunction(x) {
//    var applicationTexts = document.querySelector('.emov-p3-policy-container');
//    if (x.matches) { // If media query matches
//        applicationTexts.style.marginLeft = '0px';
//    }
//}
//var x = window.matchMedia("(max-width: 760px)")

//myFunction(x)
//x.addListener(myFunction)