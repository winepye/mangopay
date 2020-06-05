// JavaScript Document

$("#nav_btn").click(function(){
  $(this).toggleClass("act");
  $("#w_gnb").toggleClass("act");
});

$("#w_gnb > li > a").click(function(){
  $(this).next("ul").slideToggle(300);
});