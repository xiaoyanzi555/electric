
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <form id="inspection_making_dataForm" action="/inspection" method="post">
            <div class="easyui-dialog" title="分配巡检任务" id="distribution_dialog" style="width:450px"
                 data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:dis_dl_save},
            {text:'取消',handler:dis_cl_save}]">
            </div>
            <table>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>任务编号：</label>
                    </td>
                    <td align="left">
                        <input name="task_code" id="task_code" type="text" style="width: 200px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请以A-Z字母开头">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>任务名称：</label>
                    </td>
                    <td align="left">
                        <input name="task_name" type="text" style="width: 200px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>巡检线路：</label>
                    </td>
                    <td align="left">
                        <select name="line_id" class="easyui-combobox" id="lines"
                                style="width: 200px;height: 28px" data-options="onChange:find_start_end"></select>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>巡检员：</label>
                    </td>
                    <td align="left">
                        <textarea cols="15" rows="5" id="ins_peoples" readonly style="width: 200px"></textarea>
                        <input type="hidden" name="staff_ids" id="staff_ids">
                    </td>
                    <td><a href="#" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove',plain:true,onClick:openChoose"></a></td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>起始杆号：</label>
                    </td>
                    <td align="left">
                        <input readonly name="start_pole_code" id="start_pole_id" style="width: 200px;height: 28px">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>结束杆号：</label>
                    </td>
                    <td align="left">
                        <input readonly name="end_pole_code" id="end_pole_id" style="width: 200px;height: 28px">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>下发人：</label>
                    </td>
                    <td align="left">
                        <input type="hidden" name="distribute_id" style="color: #ccc;border: none;outline: none" readonly value="${user.id}">
                        <input  style="color: #ccc;border: none;outline: none" readonly value="${user.account}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>下发日期：</label>
                    </td>
                    <td align="left">
                         <input name="distribute_time" readonly id="distribute_time"
                                style="width: 200px;color: #ccc;border:none;font-size: 12px;
                                outline: none;">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>备注：</label>
                    </td>
                    <td align="left">
                        <textarea name="remark" id="" cols="25" rows="5" style="width: 200px"></textarea>
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #inspection_making_dataForm tr{line-height: 48px}
</style>
<script type="text/javascript">
    $(function () {
        var datatime=getDate();
        $("#distribute_time").val(datatime);

        //查询所有巡检线路
        $.ajax({
            url:'/lines',
            type:'get',
            headers:{"data":"select"},
            success:function (result) {
                if(result.code==200){
                    $("#lines").combobox({
                        data:result.data,
                        valueField:"id",
                        textField:"text"
                    })
                }
            }
        })
    })
    //校验任务编码
    $("#task_code").blur(function () {
        //校验任务编码
        var regex=/^[A-Z]/;
        if(!regex.test($("#task_code").val())){
            $(this).val("");//清空数据
            $(this).focus();//再次聚焦
        }
    });
</script>