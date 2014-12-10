$(document).ready(function() {
  bindEvents();
  // setBackground();
});

function bindEvents(){
   $("#search").on("submit", function(evt) {
      var that = this
      formShake(that);
      evt.preventDefault();
        $.ajax({
            url: '/looking',
            type: 'get',
            data: $(that).serialize()
        }).done(function(data) {
         cItem = data.split(" ").join("%20")
         $.ajax({
              url: '/found',
              type: 'post',
              data: {key: cItem},
         }).done(function(data){
            console.log(data);
            var link = data.link;
            var image = data.image;
            var price = data.price;
            var name = data.name;
            clearItems();
            buildItem(link, image, price, name);
            setBackground();
         })
        }).fail(function() {
          alert("Probably AJAX...")
        });
    });
};

var clearItems = function(){
  item = $(".current");
  item.remove();
};

var buildItem = function(link, image, price, name){
  for (var i = 0; i < link.length; i++) {
    var itemTemplate = $.trim($('#item_template').html());
    var $item = $(itemTemplate);
    $($item).addClass("current")
    $item.find('span').text(name[i]);
    $item.find('a').attr("href", link[i]);
    $item.find('img').attr("src", image[i]);
    $item.find('strong').text(price[i]);
    var item = $($item).css("display", "none")
    $(item).prependTo("#breaker").show('slide', 1000)
  };
}

var setBackground = function(){
  $('body').css({"background-size": "100%"})
};

var formShake = function(form){
  $(form).effect('shake', 1000);
  $("#welcome").effect('shake', 1000);
}