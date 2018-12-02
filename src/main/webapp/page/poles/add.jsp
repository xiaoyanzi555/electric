<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/5
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <form id="poles_dataForm" action="/poles" method="post">
            <table>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>杆塔编号：</label>
                    </td>
                    <td align="left">
                        <input name="pole_code" type="text" style="width: 200px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>启用状态：</label>
                    </td>
                    <td align="left">
                        <input name="use_state" type="radio" value="1" checked>启用
                        <input name="use_state" type="radio" value="2">禁用
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #poles_dataForm tr{line-height: 48px}
</style>