$(function() {

$('#upDateBtn').click(function() {
let formData=new FormData($('#updateForm'[0]))
	$.ajax({
                type: 'post',
               
                 enctype:'multipart/form-data',
                proccessData: false,
                contentType: false,
                 url: '/spring/user/uploadUpdate',
                data: formDate, 
                success: function(data) {
                   alert(data);location.href="/spring/user/uploadList";
                },
                error: function(e) {
                    console.log(e);
                }
            });

            
        });
           
});


