$(function() {
    // 아이디 중복 체크
    $('#id').focusout(function() {
        $('#idDiv').empty();

        if ($('#id').val() == '') {
            $('#idDiv').html('먼저 아이디 입력');
        } else {
            $.ajax({
                type: 'post',
                url: '/spring/user/getExistId',
                data: { id: $('#id').val() }, // 데이터 객체로 변경
                dataType: 'text',
                success: function(data) {
                    if (data == 'exist') {
                        $('#idDiv').html('사용 불가능');
                        $('#idDiv').css('color', 'red');
                    } else {
                        $('#idDiv').html('사용 가능');
                        $('#idDiv').css('color', 'blue');
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
    });

    // 회원가입 버튼 클릭
    $('#writeBtn').click(function() { // , 삭제
        $('#idDiv').empty();
        $('#pwdDiv').empty();
        $('#nameDiv').empty();

        if ($('#name').val() == '') {
            $('#nameDiv').html('이름 입력');
        } else if ($('#id').val() == '') {
            $('#idDiv').html('아이디 입력');
        } else if ($('#pwd').val() == '') {
            $('#pwdDiv').html('비밀번호 입력');
        } else {
        console.log($('#writeform').serialize());
            $.ajax({
                type: 'post',
                url: '/spring/user/write',
                data: $('#writeform').serialize(), 
                success: function() {
                    alert('회원가입 완료');
                    location.href='/spring/user/list'
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
    });
});













