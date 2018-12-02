<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div class="easyui-dialog" title="分配巡检任务" id="distribution_dialog" style="width:450px"
         data-options="closed:true,top:50,
             buttons:[
                {text:'保存',handler:dis_dl_save},
                {text:'取消',handler:dis_cl_save}]">
    </div>
        <form id="inspection_making_dataForm" action="/inspection" method="put">
            <input type="hidden" name="id" value="{{id}}">
            <table>
                <tr>
                    <td align="right" style="width: 150px">
                        <label>任务编码：</label>
                    </td>
                    <td align="left">
                        <input name="task_code" id="task_code" type="text" style="width: 200px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{task_code}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>任务名称：</label>
                    </td>
                    <td align="left">
                        <input name="task_name" type="text" style="width: 200px;height: 28px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true" value="{{task_name}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>巡检线路：</label>
                    </td>
                    <td align="left">
                        <select name="line_id" class="easyui-combobox" id="lines"
                                style="width: 200px;height: 28px" data-options="onChange:find_start_end"></select>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>巡检员：</label>
                    </td>
                    <td align="left">
                        <textarea cols="15" rows="5" id="ins_peoples" readonly style="width: 200px"></textarea>
                        <input type="hidden" name="staff_ids" id="staff_ids">
                    </td>
                    <td><a href="#" class="easyui-linkbutton"
                           data-options="iconCls:'icon-remove',plain:true,onClick:openChoose" ></a></td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>起始杆号：</label>
                    </td>
                    <td align="left">
                        <input readonly name="start_pole_code" id="start_pole_id" value="{{start_pole_code}}"
                               style="width: 200px;height: 28px">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>结束杆号：</label>
                    </td>
                    <td align="left">
                        <input readonly name="end_pole_code" id="end_pole_id" value="{{end_pole_id}}"
                               style="width: 200px;height: 28px">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>下发人：</label>
                    </td>
                    <td align="left">
                        <input  style="color: #ccc;border: none;outline: none" readonly value="${user.account}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>下发日期：</label>
                    </td>
                    <td align="left">
                         <input  readonly id="distribute_time"
                                style="width: 200px;color: #ccc;border:none;font-size: 12px;
                                outline: none;" value="{{distribute_time}}">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>备注：</label>
                    </td>
                    <td align="left">
                        <textarea name="remark" id="" cols="25" rows="5" style="width: 200px">{{remark}}</textarea>
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #inspection_making_dataForm tr{line-height: 48px}
</style>
<script type="text/javascript">
    $(function () {
        //查询所有的线路并让其选中
        $.ajax({
            url:'/lines/{{line_id}}',
            headers:{"data":"check"},
            type:'get',
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
        //根据该任务编号在关联表中查取出巡检员的id并把该名称放到控件里面
        $.ajax({
            url:'/users',
            data:{task_id:"{{id}}",pos_type:1},
            headers:{"select":"uic"},
            type:'get',
            success:function (result) {
                if(result.code==200){
                    //循环data将其构建为一个字符串添加在控件里
                    var users=result.data;
                    var nameArray=[];
                    $.each(users,function (i) {
                        nameArray.push(users[i].uname);
                    })
                    //转化为字符串进行附加
                    $("#ins_peoples").html(nameArray.join(","))
                }
            }
        })

    })
</script>