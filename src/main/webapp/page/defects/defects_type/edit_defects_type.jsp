<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <form id="defects_type_dataForm" action="/defects_type" method="put">
            <input type="hidden" name="id" value="{{id}}">
            <table>
                <tr>
                    <td align="right" style="width: 120px">
                        <label>缺陷类型名称</label>
                    </td>
                    <td align="left">
                        <input name="defect_type" id="line_code" type="text" style="width: 200px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{defect_type}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>启用状态</label>
                    </td>
                    <td align="left">
                        <input name="use_state" type="radio" value="1" {{use_state==1?"checked":""}}>启用
                        <input name="use_state" type="radio" value="2" {{use_state==2?"checked":""}}>不启用
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #defects_type_dataForm tr{line-height: 48px}
</style>