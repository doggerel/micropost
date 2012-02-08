$(document).ready(function(){
  $("#mpost_content").charCount({
      allowed: 140,		
      warning: 20,
      counterText: 'Characters left: '	
  });
  $('#mpost_content').limit('140');
});
