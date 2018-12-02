<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/6
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
    <script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/js/template-web.js"></script>
    <script type="text/javascript" src="/static/js/easyui-extend.js"></script>
    <script type="text/javascript" src="/static/js/check.js"></script>
    <script type="text/javascript" src="/static/js/find.js"></script>
</head>
<body style="background: #F4F4F4;margin: 0">
<div class="easyui-dialog" title="查看待办事宜" id="waiting_task_dialog" style="width:450px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'返回',handler:cancelDialog}]"></div>
<table class="easyui-datagrid" id="waiting_task_dg"
       data-options="pagination:true,url:'/workTask',method:'get',
       loadFilter:loadFilter,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'wait_task_type_String',width:300,height:210,align:'center'">待办任务类型</th>
        <th data-options="field:'wait_task_name',width:310,align:'center'">待办任务名称</th>
        <th data-options="field:'arrive_time',width:310,align:'center'">到达时间</th>
        <th data-options="field:'_operation',width:330,align:'center',formatter:operaterTask">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        var $waiting_task_dd=$("#waiting_task_dialog");
        var $waiting_task_dg=$("#waiting_task_dg");
        var pos=new Array();
        var renders={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/workbench/waiting_list/detail.jsp");
        //过滤datagrid信息进行展示
        function loadFilter(result) {
            if(result.code==200){
                return result.data;
            }else{
                return {};
            }
        }
        function saveDialog() {
            $("#waiting_task_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#waiting_task_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            var $waiting_task_dataForm=$("#waiting_task_dataForm");
            if(flag){
                $.ajax({
                    url:$waiting_task_dataForm.attr("action"),
                    type:$waiting_task_dataForm.attr("method"),
                    data:$waiting_task_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $waiting_task_dd.dialog("close");
                            $waiting_task_dg.datagrid("reload");
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
        function cancelDialog() {
            $waiting_task_dd.dialog("close");
        }
        function operaterTask(val,row,index) {
            return '<a href="#" class="button" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
             '<a href="#" class="button" rel="nofollow" onclick="dealFunc('+index+')">处理</a>&nbsp;'
        }
        function lookFunc(index) {
            $waiting_task_dg.datagrid("selectRow",index);
            var rows=$waiting_task_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时查看多行");
            }else if(rows.length==1){
                $.get("/inspection/"+rows[0].wait_task_id,function(result){
                    if(result.code==200){
                        $waiting_task_dd.dialog({"href":"","content":renders.editRender(result.data)});
                        $waiting_task_dd.dialog("open");
                    }
                })
            }else {
                $.messager.alert("提示","未选中目标");
            }

        }
        function dealFunc() {

        }
    </script>

</body>
</html>
