$(document).ready(function(){
  var source   = $("#student").html() || "";
  var template = Handlebars.compile(source);
  var $studentsContainer = $("#students");

  populateStudents($studentsContainer, template);
  addStudentEvents();
});

function addStudentEvents(){
  $("body").on("change", "form", function( event ){
    event.preventDefault();
    $.post(this.action, $(this).serialize(), function(res){
      console.log(res);
    });
    this.classList.add("completed");
  });

  $("body").on("click", ".avatar", function(event){
    var $form = $(this).closest("form")[0];
    $form.find("input").attr("checked", false);
    $form.classList.remove("completed");
    $.post($form.attr("action"), $form.serialize(), function(res){
      console.log(res);
    });
  });

  $("body").on("click", "#magnifyAvatars", function(event){
    $avatars = $(".avatar");
    if(this.checked){
      $avatars.addClass('magnify');
    } else {
      $avatars.removeClass('magnify');
    }
  });
}

function getStudents(callback){
  $.getJSON("http://api.wdidc.org/students?callback=?", function( students ){
    callback(students);
  });
}

function populateStudents($studentsContainer, template){
  getStudents(function(students){
    updateStatuses(students, function(){
      studentEls = renderStudents(students, template);
      $studentsContainer.append(studentEls);
    });
  });
}

function renderStudents(students, template){
  return students.map(function(student){
    return renderStudent(student, template);
  });
}

function renderStudent(student, template){
  student[student.status] = "checked='checked'";
  var html = template(student);
  var $el = $(html);
  if( student.status ){
    $el.addClass("completed");
  }
  return $el;
}

function updateStatuses(students, callback ){
  $.getJSON("http://api.wdidc.org/attendance"+ window.location.pathname +"?callback=?", function(events){
    for( var i = 0; i < events.length; i++ ){
      for( var j = 0; j < students.length; j++ ){
        if(events[i].githubUserId == students[j].github_user_id){
          students[j].status = events[i].status;
        }
      }
    }
    callback();
  });
}
