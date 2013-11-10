//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .


jQuery(function($){
  $(".command").focus(function(){
    console.log('sup')
    setTimeout(function(){
      this.select()
    }.bind(this), 5)
  })
})
