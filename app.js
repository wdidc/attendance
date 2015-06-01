var source   = $("#student").html();
var students = document.querySelector(".students")
var template = Handlebars.compile(source);

function getStudents(callback){
  $.getJSON("http://api.wdidc.org/students?callback=?", function( students ){
    callback(students)
  }) 
}

function updateStatuses(students, callback ){
  $.getJSON("http://localhost:2371/attendance/w10d03?callback=?", function(events){
    for( var i = 0; i < events.length; i++ ){
      for( var j = 0; j < students.length; j++ ){
	if(events[i].githubUserId == students[j].github_id){
	   students[j].status = events[i].status
	}
      }
    }
    callback() 
  })
}

getStudents(function(students){
  updateStatuses(students, function(){
    for( var i = 0; i < students.length; i++ ){
      var context = students[i]
      var status = context.status
      context[status] = "checked='checked'"
      var html = template(students[i])
      $(".students").append( html )
    }
  })
})

$("body").on("change", "form", function(event){
  if( !this.classList.contains("completed") ){
    students.removeChild(this)
    students.appendChild(this)
  }
  this.classList.add("completed")
})