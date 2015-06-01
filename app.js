var source   = $("#student").html();
var students = document.querySelector(".students")
var template = Handlebars.compile(source);
$.getJSON("http://api.wdidc.org/students?callback=?", function( students ){
  console.log( students )	  
  for(var i = 0; i < students.length; i++){
    if(i==3)
      return
    var html = template(students[i])
    $(".students").append( html )
  }
}) 
$("body").on("change", "form", function(event){
  console.log(this)
  if( !this.classList.contains("completed") ){
    students.removeChild(this)
    students.appendChild(this)
  }
  this.classList.add("completed")
})