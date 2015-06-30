var source   = $("#student").html() || "";
var forms = $("form")
var students = document.querySelector(".students")
var template = Handlebars.compile(source);

function getStudents(callback){
  $.getJSON("http://api.wdidc.org/students?callback=?", function( students ){
    callback(students)
  }) 
}

function updateStatuses(students, callback ){
  $.getJSON("http://api.wdidc.org/attendance"+ window.location.pathname +"?callback=?", function(events){
    for( var i = 0; i < events.length; i++ ){
      for( var j = 0; j < students.length; j++ ){
	if(events[i].githubUserId == students[j].github_user_id){
	   students[j].status = events[i].status
      }
      }
    }
    callback() 
  })
}

if(students){
  getStudents(function(students){
    updateStatuses(students, function(){
      for( var i = 0; i < students.length; i++ ){
	var context = students[i]
	var status = context.status
	context[status] = "checked='checked'"
	var html = template(students[i])
        var form = $(html)
        if( context.status ){
	  form.addClass("completed")
	}
	$(".students").append( form )
      }
    })
  })
}

$("body").on("change", "form", function( event ){
  event.preventDefault()
  $.post(this.action, $(this).serialize(), function(res){
    console.log(res)
  })
  this.classList.add("completed")
})


