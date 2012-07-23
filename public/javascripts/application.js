$(document).ready(function() {
	
	$("input:radio[type=radio]").click(function() {
	   $("#feedback_answers").val('')	
	   id = $(this).attr('id');
       ids = id.split("_")
       question_id = ids[0]
       answer_id = ids[1]
       var answers = [];
       $('#' + question_id + '_answer').val(question_id + "-" + answer_id);
       $(".answer").each(function(index, value){
    	 answer_id = $(this).val();
    	 if(answer_id != ""){
    	   current_val = $("#feedback_answers").val()
    	   new_val = current_val + "" + answer_id + ","  
    	   $("#feedback_answers").val(new_val);
    	 } 
       });
	});
    
    

    
    $("#save").click(function() {
    	$(".radio_select").attr('disabled', 'disabled')
    	id = $("#feedback_id").val();
    	answer_list = $("#feedback_answers").val();
    	extra_note = $("#feedback_extra_note").val();
    	confirm = $("#feedback_read_confirmation").val(); 
    	level1 = $("input:radio[name=feedback_recommandation_level]:checked").val();
    	level2 = $("input:radio[name=feedback_recommandation_level_highly_recommand]:checked").val();
    	$.ajax({ 
	      url:'/feedbacks/' + id,
	      type: 'PUT', 
	      dataType: 'json',
	      data: {'answers': answer_list, 'extra_note': extra_note, 'confirm': confirm, 'level1': level1, 'level2' : level2},
	      success: function(content) {
             window.location.href = "/"
          }
	    });
	    return false; 
    });
    
    
    
    $("#principal_feedback_step1").hide();
    
    $("select").change(function () {
    	  var str = "";
	      $("select option:selected").each(function () {
	            str += $(this).text();
	            if(str == "No"){
	      		  $("#principal_feedback_step1").show('slow');	
	      		}
	      		if(str == "Yes"){
	      		  $("#principal_feedback_step1").hide('slow');	
	      		}
	      });
	});
	
	//hide both messages in school
	$("#eas_yes").hide('fast');
	$("#eas_no").hide('fast');
	
	$("#student_school_id").change(function() {
    	  var str = "";
	      $("#student_school_id option:selected").each(function () {
	      	    show_messages($(this).text());
	            
	   	  });
	});
	
    category = $("#student_school_id option:selected").text()
    show_messages(category);
	
	$("#student_login_email").val('');
	$("#student_login_email").attr('readonly', true);
	
	$("#student_email").focusout(function() {
		name = $(this).val();
		$("#student_login_email").val(name);
	});
	//handling page validation load
	$("#student_login_email").val($("#student_email").val());
	$("#dialog-confirm").hide('fast');
	$("#final_submit").click(function (){
		$("#dialog-confirm").show('fast');
		$( "#dialog-confirm" ).dialog({
		  resizable: false,
		  height:140,
		  modal: true,
		  buttons: {
			"Submit Form": function() {
				$( this ).dialog( "close" );
				$("#final_submit_flag").val("1");
				$("#student_submit").click();
				
			},
			Cancel: function() {
				$( this ).dialog( "close" );
				$("#dialog-confirm").hide('fast');
				return false;
			}
			}
		});
		return false;
		
	});
	
	//setting up e-mail and confirm e-mail
	$("#student_email_confirmation").val($("#student_email").val());
	
})

function show_messages(str){
	start = str.indexOf("(")
	end   = str.indexOf(")")
	category = str.substr(start, end)
	if (category != ""){
    	if (category == "(EAS)"){
			$("#eas_yes").show('slow');
        	$("#eas_no").hide('slow');
		}	
		else{
			$("#eas_yes").hide('slow');
            $("#eas_no").show('slow');
		}	
    }
    else{
    	$("#eas_yes").hide('slow');
        $("#eas_no").hide('slow');
    }
}
