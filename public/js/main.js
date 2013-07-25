$(document).ready(function(e){
  $('#transliterate_cmd').click(function(e){
    if (!$('#text_input').val()=='') {
      $.get('/'+$('#text_input').val(), function(data){
        $('#result').html(data);
      });
    }
    else {
      $('#result').html('<span class="elucidation">(output here)</span>');
    }
    return false;
  });
});