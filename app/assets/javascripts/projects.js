// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('DOMContentLoaded', function(){
  document.getElementById('new-project').addEventListener('click', function(){
    $.ajax({
      url: document.getElementById('new-project').dataset.url,
      beforeSend: function(){
        $('#modal-reload').empty();
      },
      success: function(result){
        $('#modal-reload').append(result);
        $('#modal').fadeIn();
        $('#modal-reload').append('<div class="overlay"></div>');
      },
    });
  });
});
