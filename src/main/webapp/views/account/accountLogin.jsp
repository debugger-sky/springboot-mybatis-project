<%--
  Created by IntelliJ IDEA.
  User: blucean
  Date: 2020-06-01
  Time: 오후 4:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/views/common/htmlHead.jsp" %>
<html>
<head>
    <title>로그인</title>
    <style>
        a img {
            width: 2.0rem;
            height: 2.0rem;
        }

        a span {
            font-stretch: expanded;
            font-size: 2.0rem;
        }

        .all {
            margin-top: 100px;
        }

        .col input {
            width: 300px;
            max-width: 300px;
        }

        .col button {
            width: 300px;
            max-width: 300px;
        }

        .alert {
            min-width: 300px;
            max-height: 60px;
            position: fixed;
            display: none
        }


    </style>
    <script type="text/javascript">
        $(document).ready(function () {
                $('#login_btn').click(function () {
                    let accountEmail = $('input[name="accountEmail"]').val().replace(/ /g, ''); // 모든 공백 제거
                    let accountPassword = $('input[name="accountPassword"]').val().replace(/ /g, '');

                    if (isEmpty(accountEmail)) {
                        $('.alert').fadeIn(400).delay(1000).fadeOut(400); //fade out after 3 seconds
                        $('#alertMsg').html("아이디를 입력해 주세요!");
                        // alert("아이디를 입력해 주세요!");
                        $('#accountEmail').val(null).focus();

                        return false;
                    }

                    if (isEmpty(accountPassword)) {
                        $('.alert').fadeIn(400).delay(1000).fadeOut(400); //fade out after 3 seconds
                        $('#alertMsg').html("패스워드를 입력해 주세요!");
                        // alert("패스워드를 입력해 주세요!");
                        $('#accountPassword').val(null).focus();
                        return false;
                    }
                    return login();
                });
            }
        );

        // 값 체크
        let isEmpty = function (value) {
            return value === "" || value == null;
        }

        function login() {
            let requestUrl = '/account/loginProc';
            let form = $('#form')[0];
            let data = new FormData(form);
            console.log("Insert Request Data:", data);
            $.ajax({
                type: "POST",
                url: requestUrl,
                data: data,
                processData: false,
                contentType: false,
                // cache: false,
                // timeout: 600000,
                success: function (response) {
                    console.log("Insert Response Data:", response);
                    if (response.resCode === 1000) {
                        alert(response.resMsg);
                        location.replace('/');
                    } else if (response.resCode === 1001) {
                        // alert(response.resMsg);
                        $('.alert').fadeIn(400).delay(2000).fadeOut(400);
                        $('#alertMsg').html(response.resMsg);
                        // window.location.reload();
                    } else if (response.resCode === 1002) {
                        alert(response.resMsg);
                        window.location.reload();
                    }
                },
                error: function (xhr, e, response) {
                    console.log("Insert Error:", xhr, e, response);
                    alert("에러!!")
                }
            });
        }
    </script>
</head>
<body class="bg-light">
<div class="all">
    <div class="container">
        <div class="row justify-content-center">
            <%-- 유효성 검사 토스트 창 --%>
            <div class="alert alert-danger text-center" role="alert">
                <span id="alertMsg"></span>
            </div>
            <div class="row navbar navbar-light" style="padding-top: 80px">
                <a class="col navbar-brand" href="/">
                    <img src="${pageContext.request.contextPath}/resources/images/cubes-solid.svg"
                         class="d-inline-block align-baseline" alt="logo">
                    <span class="d-inline-block align-bottom">Blucean</span>
                </a>
            </div>
        </div>
        <form id="form">
            <div class="row justify-content-center">
                <div class="list-group row">
                    <div class="col">
                        <input type="text" class="list-group-item" id="accountEmail" name="accountEmail"
                               placeholder="아이디"/>
                        <input type="password" class="list-group-item" id="accountPassword" name="accountPassword"
                               placeholder="패스워드"/>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mt-3">
                <div class="row">
                    <div class="col">
                        <input type="button" id="login_btn" class="btn btn-secondary" value="L O G I N"/>
                    </div>
                </div>
            </div>
        </form>
        <div class="row justify-content-center mt-3">
            <div class="row">
                <div class="col">
                    <a class="badge badge-light" href="javascript:void(0);">비밀번호 찾기</a>
                </div>
            </div>
            <div class="row ml-1">
                <div class="col">
                    <a class="badge badge-light" href="javascript:void(0);">회원가입</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
