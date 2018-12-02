<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/19
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
<script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
<script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/static/js/template-web.js"></script>
<script type="text/javascript" src="/static/js/easyui-extend.js"></script>
<script type="text/javascript" src="/static/js/find.js"></script>
<script type="text/javascript">
    $(function () {
        //工作单据的下拉选择
        $("#work_receipt").combobox({
            data:[{
                "id":"",
                "text":"---请选择---",
                "selected":true
            },{
                "id":1,
                "text":"任务单"
            },{
                "id":2,
                "text":"第一种单据"
            },{
                "id":3,
                "text":"第二种单据"
            }],
            valueField:'id',
            textField:'text'
        })
        //设定日期
        $("#distribute_time").val(getDate());

    })
</script>
<div id="ConsumeData" style="background: #fff">
    <div class="easyui-dialog" title="选择消缺员" id="small_dialog" style="width:450px"
         data-options="closed:true,top:50,
             buttons:[
                {text:'保存',handler:smallSave},
                {text:'取消',handler:smallCancel}]">
    </div>
        <form id="ComsumeDataForm" action="/consumeTask" method="post">
            <table>
                <tr>
                    <td>
                        <strong> 任 务 编 码： </strong>
                        <input style="width: 200px;height: 28px" name="consume_task_code">
                    </td>
                    <td>
                        <strong style="margin-left: 30px">任务名称：</strong>
                        <input style="width: 200px;height: 28px" name="task_name">
                    </td>
                    <td>
                        <strong style="margin-left: 30px">工作单据：</strong>
                        <select style="width: 200px;height: 28px" id="work_receipt" name="work_documents"></select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>任务负责人：</strong>
                        <input style="width: 200px;height: 28px" readonly id="task_user">
                        <input type="hidden" name="task_user_id">
                    </td>
                    <td style="margin-left: 30px">
                        <strong style="margin-left: 30px">下发人：</strong>
                        <label style="display:inline-block;width: 200px">${user.uname}</label>
                        <input type="hidden" name="distribution_id" value="${user.id}">
                    </td>
                    <td style="margin-left: 30px">
                        <strong style="margin-left: 30px">下发日期：</strong>
                        <input id="distribute_time" style="display:inline-block;width: 200px;height: 28px" name="distribute_time">
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>任务描述</strong>
                        <textarea cols="18" rows="8" name="task_description"></textarea>
                    </td>
                    <td>
                        <strong>备注</strong>
                        <textarea cols="18" rows="8" name="remark"></textarea>
                    </td>
                    <td>
                        <strong>消缺员</strong>
                        <textarea cols="18" rows="8" id="consomers"></textarea>
                        <input type="hidden" name="consomers" id="consomers_id">
                        <input type="hidden" name="defects" id="defects_id">
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:chooseConsume"></a>
                    </td>
                </tr>
            </table>
        </form>
        <strong>缺陷列表</strong>
        <button onclick="addDefect()">添加缺陷</button>
            <table id="showDefect" class="easyui-datagrid">
                <thead>
                    <tr>
                        <th data-options="field:'line_code'">线路编号</th>
                        <th data-options="field:'pole_code'">杆塔编号</th>
                        <th data-options="field:'defect_gradeString'">缺陷级别</th>
                        <th data-options="field:'defect_type_string'">缺陷类型</th>
                        <th data-options="field:'defect_description'">缺陷描述</th>
                        <th data-options="field:'find_user_name'">发现人</th>
                        <th data-options="field:'find_time'">发现时间</th>
                        <th data-options="field:'_operation',formatter:opDefect">操作</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <div class="easyui-dialog" title="缺陷信息" id="defects_dialog" style="width:600px"
                 data-options="closed:true,top:50,
                 buttons:[
                    {text:'确定',handler:saveDialog},
                    {text:'取消',handler:cancelDialog}]">
                <table class="easyui-datagrid" id="defect_select_dg"
                       data-options="pagination:true,url:'/defects',method:'get',
                       loadFilter:loadFilter,striped:true,rownumbers:true,queryParams:{isComsume:1}">
                    <thead>
                    <tr>
                        <th data-options="checkbox:true">选择</th>
                        <th data-options="field:'line_code'">线路编号</th>
                        <th data-options="field:'pole_code'">杆塔编号</th>
                        <th data-options="field:'defect_gradeString'">缺陷级别</th>
                        <th data-options="field:'defect_type_string'">缺陷类型</th>
                        <th data-options="field:'defect_description'">缺陷描述</th>
                        <th data-options="field:'find_user_name'">发现人</th>
                        <th data-options="field:'find_time'">发现时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        <div style="margin-top: 30px">
            <button style="padding: 5px 8px" onclick="saveConsume()">保存</button>
            <button style="padding: 5px 8px;margin-left: 30px" onclick="fanhui()">返回</button>
        </div>
</div>
<style type="text/css">
    table tr{line-height: 48px}
</style>
<script type="text/javascript">
    function opDefect(val,row,index) {
        return '<a href="#" rel="nofollow" onclick="RemoveFunc('+index+')">移除</a>';
    }
    function RemoveFunc(index) {
        $("#showDefect").datagrid("deleteRow",index);
    }
    function addDefect() {
        //弹出对话框，里面是缺陷数据
        $("#defects_dialog").dialog("open")
    }
    function loadFilter(result) {
        if(result.code==200){
            return result.data;
        }else{
            return {};
        }
    }
    function saveDialog() {
        //获得所选中的
        var rows=$("#defect_select_dg").datagrid("getSelections");
        //添加到下一个datagrid之中
        $.each(rows,function (i) {
            $("#showDefect").datagrid("appendRow",rows[i])
        })
        //关闭该对话框
        cancelDialog();
    }
    function cancelDialog() {
        $("#defects_dialog").dialog("close")
    }
    function chooseConsume() {
        $("#small_dialog").dialog({"href":"/page/comsume/comsume_making/chooseComsumer.jsp"});
        $("#small_dialog").dialog("open")
    }

    function smallSave() {
        //点击保存后获得其人员的名字，将其放入text文本之后
        var names=[];
        var peopleids=[];
        $("#check_consumer option").each(function () {
            names.push($(this).text());
            peopleids.push($(this).val());
        })
        //将其放在文本域之中，且第一个默认为负责人
        $("#consomers").html(names.join(","))
        $("#consomers_id").val(peopleids.join(","))
        //将第一个人的名字赋值给组长
        $("#task_user").val(names[0]);
        $("#task_user_id").val(peopleids[0]);
        smallCancel();
    }
    function smallCancel() {
        $("#small_dialog").dialog("close");
    }

    function saveConsume() {
        //获得该标签下所有的行信息
        $("#showDefect").datagrid("selectAll");
        var rows=$("#showDefect").datagrid("getSelections");
        //获得所选择缺陷的id
        var defectids=[];
        $.each(rows,function (i) {
            defectids.push((rows[i].id));
        })
        //将其进行赋值
        $("#defects_id").val(defectids.toString());
        //对表单进行提交
      /*  $.confirm("警告","确定要提交吗？",function (r) {
            if(r){*/
                $.ajax({
                    type:$("#ComsumeDataForm").attr("method"),
                    url:$("#ComsumeDataForm").attr("action"),
                    data:$("#ComsumeDataForm").serialize(),
                    success:function(data){
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            //调用返回方法
                            //保存完之后关闭按
                            window.location.href="/page/comsume/comsume_making/list.jsp";
                        }else{
                            $.messager.show({
                                title:"错误",
                                msg:data.msg,
                                showType:'slide'
                            })
                        }
                    },
                    error:function(e){
                        $.messager.show({
                            title:"其他错误",
                            msg:e,
                            showType:'slide'
                        })
                    }
                })
           /* }
        })*/
    }
    function fanhui() {
        window.location.href="/page/comsume/comsume_making/list.jsp";
    }
</script>


