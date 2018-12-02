<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/11
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8"/>
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
    <script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/js/template-web.js"></script>
</head>
<body style="background: #0B61A4">
    <div class="easyui-dialog" id="login_dg" title="" style="width: 500px;height: 300px;background: #4d68a4">
        <h1 style="color: #fff;text-align: center">电力巡检系统</h1>
        <p style="color: #fff;text-align: center">请输入用户名和密码登录</p>
        <form id="login_dataForm" method="post">
            <table style="width: 100%">
                <tr style="line-height: 30px">
                    <td align="center" style="width: 30%">
                        <label style="color: #fff">用户名</label>
                    </td>
                    <td>
                        <input type="text" name="account" style="width: 200px;height: 30px;" id="mm">
                    </td>
                </tr>
                <tr style="line-height: 30px">
                    <td align="center" style="width: 30%">
                        <label style="color: #fff">密码</label>
                    </td>
                    <td>
                        <input type="password" name="pass" style="width: 200px;height: 30px;" >
                    </td>
                </tr>
            </table>
            <div>
                <input type="submit" value="登录"
                       style="display: inline-block;width: 80%;margin: 20px 40px;height: 30px;background: blue;border: none">
            </div>

        </form>
    </div>
<script type="text/javascript">
    /*function saveDialog() {
        $.ajax({
            url:"/login",
            type:'get',
            data:$("#login_dataForm").serialize(),
            success:function (result) {
                if (result.code==200){
                    //跳转页面
                    window.location.href="index.jsp?";
                }else{
                    $.messager.alert("提示","登录错误")
                }
            },
            error:function(){
                $.messager.alert("错误","登录错误")
        }
        })
    }*/
</script>
</body>
</html>
