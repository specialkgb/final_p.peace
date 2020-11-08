$(function () {
  $("section#login_modal").click();

  $("#login_pop").click(function () {
    $("section#login_modal").show();
  });

  $("#btn_login").click(function (e) {
    let n_userid = $("#login #n_userid").val();
    let n_email = $("#login #n_email").val();
    let n_password = $("#login #n_password").val();
    if (n_userid == "") {
      alert("로그인 id는 반드시 입력해야 합니다");
      $("#login #n_userid").focus();
      return false;
    } else if (n_password == "") {
      alert("로그인 비밀번호는 반드시 입력해야 합니다");
      $("#login #n_password").focus();
      return false;
    }

    e.preventDefault();
    $.ajax({
      url: `${rootPath}/login`,
      type: "POST",
      data: {
        n_userid: $("#login #n_userid").val(),
        n_password: $("#login #n_password").val(),
      },

      success: function (response) {
        if (response == 1) {
          alert("로그인 성공");
          // $("#form-box").modal("hide");
          $("section#login_modal").hide();
          location.reload(); //
        } else {
          alert("로그인 실패. 비밀번호를 다시 확인해주세요");
        }
      },
       error:function(x,e){
            if(x.status==0){
            alert('You are offline!!n Please Check Your Network.');
            }else if(x.status==404){
            alert('Requested URL not found.');
            }else if(x.status==500){
            alert('Internel Server Error.');
            }else if(e=='parsererror'){
            alert('Error.nParsing JSON Request failed.');
            }else if(e=='timeout'){
            alert('Request Time out.');
            }else {
            alert('Unknow Error.n'+x.responseText);
            }
        }
    });
    // });
  });


});
