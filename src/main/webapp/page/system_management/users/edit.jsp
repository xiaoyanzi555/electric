<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="users_dataForm" method="put" action="/users">
    <input type="hidden" name="id" value="{{id}}">
    <table>
        <tr>
            <td align="right" style="width: 100px">
                <label>登录账号：</label>
            </td>
            <td align="left">
                <input name="account" type="text"  class="easyui-validatebox"
                       data-options="novalidate:true,required:true" value="{{account}}"
                       style="width: 200px;height: 28px">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>用户名称：</label>
            </td>
            <td align="left">
                <input name="uname" type="text"  class="easyui-validatebox"
                       data-options="novalidate:true,required:true" value="{{uname}}"
                       style="width: 200px;height: 28px">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>密码：</label>
            </td>
            <td align="left">
                <input name="password" type="password" class="easyui-validatebox"
                       data-options="novalidate:true,required:true" value="{{password}}"
                        style="width: 200px;height: 28px">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>角色：</label>
            </td>
            <td align="left">
                <select name="role_id" id="roles" style="width: 200px;height: 28px"></select>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>入职时间：</label>
            </td>
            <td align="left">
                <input name="hiredate_time" type="text" class="easyui-datebox" value="{{hiredate_time}}"
                       style="width: 200px;height: 28px">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>离职时间：</label>
            </td>
            <td align="left">
                <input name="dimission_time" type="text" class="easyui-datebox" value="{{dimission_time}}"
                       style="width: 200px;height: 28px">
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 80px">
                <label>使用状态：</label>
            </td>
            <td align="left">
                <input name="account_state" type="radio" value="1" {{account_state==1?"checked":""}}>正常
                <input name="account_state" type="radio" value="2" {{account_state==2?"checked":""}}>冻结
            </td>
        </tr>
    </table>
</form>
<style type="text/css">
    #users_dataForm tr{line-height: 48px}
</style>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url:"/roles/{{id}}",
            type:'get',
            headers:{"select":"role_name_id"},
            success:function(result){
                if(result.code==200){
                    $("#roles").combobox({
                        data:result.data,
                        valueField:'id',
                        textField:'text'
                    })
                }
            }
        })
    })
</script>