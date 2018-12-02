<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<meta charset="utf-8"/>
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
<script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
<script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/static/js/easyui-extend.js"></script>
<style type="text/css">
    input{
        height: 28px;
    }
    #users_info_update_dataForm tr{
        line-height: 35px;
        height: 35px;
    }
    tb{
        padding-left: 4px;
    }
    .btn{
        padding: 5px 8px;
    }
</style>
<body style="background: #F4F4F4">
    <form id="users_info_update_dataForm" method="put" action="/users" style="width: 800px;margin: 10px auto">
        <input type="hidden" name="id" value="${user.id}">
        <table>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>用户名：</strong></label>
                </td>
                <td align="left">
                    <input name="account" type="text"  class="easyui-validatebox"
                           data-options="novalidate:true,required:true" value="${user.account}"
                           style="width: 200px">
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>用户名称：</strong></label>
                </td>
                <td align="left">
                    <input name="uname" type="text"  class="easyui-validatebox"
                           data-options="novalidate:true,required:true" value="${user.uname}"  readonly
                           style="width: 200px">
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>请输入旧密码：</strong></label>
                </td>
                <td align="left" style="width: 400px">
                    <input id="oldpassword" type="password" class="easyui-validatebox"
                            style="width: 200px">
                    <label id="tip_pass" style="color: red"></label>
                </td>

            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>请输入新密码：</strong></label>
                </td>
                <td align="left">
                    <input name="password" type="password" class="easyui-validatebox"
                           style="width: 200px" id="newpass">
                    <label id="tip_newpass" style="color: red"></label>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>请确认新密码：</strong></label>
                </td>
                <td align="left">
                    <input id="surepass" type="password"
                           style="width: 200px">
                    <label id="tip_surepass" style="color: red"></label>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>性别：</strong></label>
                </td>
                <td align="left">
                    <input type="radio" name="sex" value="1" checked>男
                    <input type="radio" name="sex" value="2">女
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 200px">
                    <label><strong>生日：</strong></label>
                </td>
                <td align="left">
                    <input name="birthday" type="text" class="easyui-datebox" style="width: 200px;height: 28px">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <label><strong>入职时间：</strong></label>
                </td>
                <td align="left">
                    <input name="hiredate_time"  class="easyui-datebox" readonly style="width: 200px;height: 28px">
                </td>
            </tr>

            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>离职时间：</strong></label>
                </td>
                <td align="left">
                    <input name="dimission_time"  readonly class="easyui-datebox" style="width: 200px;height: 28px">
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>联系电话：</strong></label>
                </td>
                <td align="left">
                    <input name="phone" type="text"  style="width: 200px">
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 150px">
                    <label><strong>电子邮箱：</strong></label>
                </td>
                <td align="left">
                    <input name="email" type="text"  style="width: 200px">
                </td>
            </tr>
        </table>
    </form>
    <div style="width: 150px;margin: 10px auto">
        <button class="btn" onclick="save()" style="text-align: center;display: inline-block">保存修改</button>
        <button class="btn" onclick="cancel()" style="margin-left: 20px;text-align: center;display: inline-block">取消</button>
    </div>
    <script type="text/javascript">
        var oldpass=${user.password}
            $("#oldpassword").blur(function () {
                if(oldpass!=$(this).val()){
                    $("#tip_pass").html("旧密码输入不正确");
                    $(this).val("");
                    $(this).focus();
                }else {
                    $("#tip_pass").html("");
                }
            });
            $("#newpass").blur(function () {
                if (oldpass==$(this).val()){
                    $("#tip_newpass").html("新密码不能和旧密码一致");
                    $(this).val("");
                    $(this).focus();
                }else {
                    $("#tip_newpass").html("");
                }
            });
            $("#surepass").blur(function () {
                if ($("#newpass").val()!=$(this).val()){
                    $("#tip_surepass").html("两次输入的密码不一致");
                    $("#newpass").val("");//将之前的密码也清空
                    $(this).val("");
                    $(this).focus();
                }else {
                    $("#tip_surepass").html("");
                }
            });
            //提交
        function save() {
            $.messager.progress();
            $(".easyui-validatebox").validatebox({"novalidate":false})
            var flag=true;
            $(".easyui-validatebox").each(function() {
                if (!$(this).validatebox("isValid")) {
                    flag = false;
                    return false;

                }
            });
            var $users_dataForm=$("#users_info_update_dataForm");
            if(flag){
                $.ajax({
                    url:$users_dataForm.attr("action"),
                    type:$users_dataForm.attr("method"),
                    data:$users_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                        }else{
                            $.messager.show({
                                title:"错误",
                                msg:data.msg,
                                showType:'slide'
                            })
                        }
                    },
                    error:function(e){
                        $.messager.progress("close");
                        $.messager.show({
                            title:"出错了",
                            msg:e,
                            showType:'slide'
                        })
                    }
                })
            }else{
                $.messager.progress("close");
            }
        }
        
        //如果点击取消
        function cancel() {
            var index_page=window.parent;//index页面,父级页面
            window.parent.close();
        }
    </script>
</body>

</html>