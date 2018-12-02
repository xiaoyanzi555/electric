
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <form id="roles_dataForm" action="/roles" method="post">
        <%--创建人为当前登录人--%>
        <input type="hidden" name="createBy" value="${user.id}">
        <table>
            <tr>
                <td align="right" style="width: 100px">
                    <label>角色编号：</label>
                </td>
                <td align="left">
                    <input name="role_code" type="text" style="width: 200px;height: 28px"
                           class="easyui-validatebox"
                           data-options="novalidate:true,required:true">
                </td>
            </tr>

            <tr>
                <td align="right" style="width: 80px">
                    <label>角色名称：</label>
                </td>
                <td align="left">
                    <input name="role_name" type="text" style="width: 200px;height: 28px"
                           class="easyui-validatebox"
                           data-options="novalidate:true,required:true">
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 80px">
                    <label>是否启用：</label>
                </td>
                <td align="left">
                    <input name="use_state" type="radio" value="1" checked>启用
                    <input name="use_state" type="radio" value="2">不启用
                </td>
            </tr>
        </table>
    </form>
<style>
    #roles_dataForm tr{
        line-height: 48px;
    }
</style>
