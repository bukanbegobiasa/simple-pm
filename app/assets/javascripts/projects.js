// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function open_modal(element){
  $.ajax({
    url: element.dataset.url,
    beforeSend: function(){
      $('#modal-reload').empty();
    },
    success: function(result){
      $('#modal-reload').append(result);
      $('#modal').fadeIn();
      $('#modal-reload').append('<div class="overlay"></div>');
    },
  });
}

function toogle_new_job(){
  var el = document.getElementById('new_job');
  var st = 'none';

  if (el.style.display == 'none' || el.style.display == ''){
    st = 'block';
  }

  setTimeout(function(){
    el.style.display = st;
  },500);
}

function toogle_user_job(){
  var el = document.getElementById('new_assignment');
  var st = 'none';

  if (el.style.display == 'none' || el.style.display == ''){
    st = 'block';
  }

  setTimeout(function(){
    el.style.display = st;
  },500);
}

function toogle_new_user_project(){
  var el = document.getElementById('new_user_project');
  var st = 'none';

  if (el.style.display == 'none' || el.style.display == ''){
    st = 'block';
  }

  setTimeout(function(){
    el.style.display = st;
  },500);
}

function toogle_new_task(){
  var el = document.getElementById('new_task');
  var st = 'none';

  if (el.style.display == 'none' || el.style.display == ''){
    st = 'block';
  }

  setTimeout(function(){
    el.style.display = st;
  },500);
}
