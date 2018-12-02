
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <form id="lines_dataForm" action="/lines" method="put">
            <input type="hidden" name="id" value="{{id}}">
            <table>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>线路编码：</label>
                    </td>
                    <td align="left">
                        <input name="line_code" id="line_code" type="text" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{line_code}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>线路名称：</label>
                    </td>
                    <td align="left">
                        <input name="line_name" type="text" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{line_name}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>线路长度：</label>
                    </td>
                    <td align="left">
                        <input name="line_len" type="number" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{line_len}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>回路长度：</label>
                    </td>
                    <td align="left">
                        <input name="loop_len" type="number" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{loop_len}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>投运日期：</label>
                    </td>
                    <td align="left">
                        <input name="deliver_time" type="text" style="width: 250px;height: 28px" class="easyui-datebox" value="{{deliver_time}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>电压等级：</label>
                    </td>
                    <td align="left">
                        <input name="elec_grade" type="number" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{elec_grade}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>起始杆号：</label>
                    </td>
                    <td align="left">
                        <input name="start_pole" id="start_pole" type="text" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{start_pole}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>结束杆号：</label>
                    </td>
                    <td align="left">
                        <input name="end_pole" id="end_pole" type="text" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{end_pole}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>塔基数：</label>
                    </td>
                    <td align="left">
                        <input name="tower_base" id="tower_base" type="number" style="width: 250px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" readonly value="{{tower_base}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>备注：</label>
                    </td>
                    <td align="left">
                        <textarea cols="5" rows="5" name="remake" type="text" style="width: 250px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true">{{remake}}
                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 80px">
                        <label>启用状态：</label>
                    </td>
                    <td align="left">
                        <input name="use_state" type="radio" value="1" {{use_state==1?"checked":""}}>启用
                        <input name="use_state" type="radio" value="2" {{use_state==2?"checked":""}}>停用
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #lines_dataForm tr{line-height: 48px}
</style>
<script type="text/javascript">
    $(function () {
        check_lines();
    })
</script>