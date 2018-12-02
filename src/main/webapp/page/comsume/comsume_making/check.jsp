<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/20
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="background: #fff">
    <form id="checkDataForm" action="/consumeTask" method="put">
        <input type="hidden" name="id" value="{{comsumeTask.id}}">
        <table>
            <tr>
                <td align="right" width="150px"><strong>任务编码</strong></td>
                <td align="center" width="280px">{{comsumeTask.consume_task_code}}</td>
                <td align="right" width="150px"><strong>任务名称</strong></td>
                <td align="center" width="280px">{{comsumeTask.task_name}}</td>
            </tr>
            <tr>
                <td align="right" width="150px"><strong>任务状态</strong></td>
                <td align="center" width="280px">{{comsumeTask.task_State_String}}</td>
                <td align="right" width="150px"><strong>工作单据</strong></td>
                <td align="center" width="280px">{{comsumeTask.work_documents_String}}</td>
            </tr>
            <tr>
                <td align="right" width="150px"><strong>任务下发人</strong></td>
                <td align="center" width="280px">{{comsumeTask.distribution_name}}</td>
                <td align="right" width="150px"><strong>任务下发时间</strong></td>
                <td align="center" width="280px">{{comsumeTask.distribute_time}}</td>
            </tr>
            <tr>
                <td align="right" width="150px"><strong>任务负责人</strong></td>
                <td align="center" width="280px">{{comsumeTask.task_user_name}}</td>
                <td align="right" width="150px"><strong>工作描述</strong></td>
                <td align="center" width="280px">{{comsumeTask.task_description}}</td>
            </tr>
            <tr>
                <td align="right" width="150px"><strong>消缺员</strong></td>
                <td align="center" width="280px">
                    {{each users}}
                        {{$value.uname}}
                    {{/each}}
                </td>
                <td align="right" width="150px"><strong>任务完成时间</strong></td>
                <td align="center" width="280px">{{comsumeTask.task_complete_time}}</td>
            </tr>
            <tr>
                <td align="right" width="150px" style="height:58px"><strong>负责人审查意见</strong></td>
                <td><textarea  style="width: 280px;height: 58px" name="responsible_idea"></textarea></td>
                <td align="right" width="150px"><strong>完成情况描述</strong></td>
                <td align="center" width="280px">{{comsumeTask.execution_description}}</td>
            </tr>
            <tr>
                <td align="right" width="150px" style="height:58px"><strong>下发人审查意见</strong></td>
                <td><textarea cols="5" style="width: 280px;height: 58px" name="distribution_idea"></textarea></td>
                <td align="right" width="150px"><strong>审核是否通过</strong></td>
                <td align="center">
                    <select style="width: 100px;height: 28px" name="pass">
                        <option value="" disabled selected>----请选择----</option>
                        <option value="1">通过</option>
                        <option value="2">不通过</option>
                    </select>
                </td>
            </tr>
        </table>
        <p><strong>缺陷信息列表</strong></p>
        <table id="defects_list">
            <thead>
            <tr>
                <th>线路编号</th>
                <th>杆塔编号</th>
                <th>缺陷级别</th>
                <th>缺陷类型</th>
                <th>缺陷描述</th>
                <th>发现人</th>
                <th style="width: 300px">发现时间</th>
            </tr>
            </thead>
            <tbody>
            {{each defects}}
                <tr>
                    <td>{{$value.line_code}}</td>
                    <td>{{$value.pole_code}}</td>
                    <td>{{$value.defect_gradeString}}</td>
                    <td>{{$value.defect_type_string}}</td>
                    <td>{{$value.defect_description}}</td>
                    <td>{{$value.find_user_name}}</td>
                    <td>{{$value.find_time}}</td>
                </tr>
            {{/each}}
            </tbody>
        </table>
        <p><strong>工作间断延期记载</strong></p>
        <textarea  rows="5" style="width: 100%" name="overtime_record">{{comsumeTask.overtime_record}}</textarea>
        <p><strong>工作终结报告</strong></p>
        <textarea  rows="5" style="width: 100%" name="end_record">{{comsumeTask.end_record}}</textarea>
    </form>
    <button style="padding: 5px 8px" onclick="save()">保存</button>
    <button style="padding: 5px 8px;margin-left: 30px" onclick="fanhui()">返回</button>
</div>
    <style type="text/css">
        table{border-collapse: collapse}
        table td{
            border: 1px solid #ccc;
            height: 38px;
        }
        #defects_list th{
            background: #E4E4E4;
            height: 38px;
            width: 150px;
            border: 1px solid #ccc;
        }
        #defects_list td {
            text-align: center;
        }
    </style>
<script type="text/javascript">
    function save() {
        //发送请求修改数据
        $.ajax({
            url:$("#checkDataForm").attr("action"),
            type:$("#checkDataForm").attr("method"),
            data:$("#checkDataForm").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    $.messager.show({
                        title:"成功",
                        msg:result.msg,
                        showType:'slide'
                    })
                    $comsume_dg.datagrid("reload");
                    //返回到list界面
                    window.location.href="/page/comsume/comsume_making/list.jsp";
                } else {
                    $.messager.show({
                        title: "错误",
                        msg: result.msg,
                        showType: 'slide'
                    })
                }
            },
            error: function (e) {
                $.messager.show({
                    title: "出错了",
                    msg: e,
                    showType: 'slide'
                })
            }
        })
    }
    function fanhui() {
        window.location.href="/page/comsume/comsume_making/list.jsp";
    }

</script>
</body>
</html>
