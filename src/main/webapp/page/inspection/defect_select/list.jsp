<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/6
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
    <link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
    <script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/static/js/template-web.js"></script>
    <script type="text/javascript" src="/static/js/easyui-extend.js"></script>
    <script type="text/javascript" src="/static/js/inspection_making_add.js"></script>
    <script type="text/javascript" src="/static/js/find.js"></script>
</head>
<script type="text/javascript">
   $(function(){
       //发送请求获取所有的任务编号
       $.ajax({
           type:'get',
           url:'/inspection',
           headers:{"select":"findAll"},
           success:function(result){
               if (result.code==200){
                   $("#task_code_select").combobox({
                       data:result.data,
                       valueField:"id",
                       textField:"text"
                   })
               }
           }
       })
       //发送请求绑定线路编号
       $.ajax({
           type:'get',
           url:'/lines',
           headers:{"data":"select"},
           success:function(result){
               if (result.code==200){
                   $("#line_code_select").combobox({
                       data:result.data,
                       valueField:"id",
                       textField:"text"
                   })
               }
           }
       })
      //发送请求绑定缺陷类型
       $.ajax({
           url:"/defects_type",
           headers:{"select":"find_all"},
           type:"get",
           success:function(result){
               if (result.code==200){
                   $("#defect_type_select").combobox({
                       data:result.data,
                       valueField:"id",
                       textField:"text"
                   })
               }
           }
       })
       //绑定缺陷级别
       $("#defect_grade_select").combobox({
           data:[{
               "id":"",
               "text":"---请选择---",
               "selected":true
           },{
               "id":1,
               "text":"一般"
           },{
               "id":2,
               "text":"严重"
           },{
               "id":3,
               "text":"紧急"
           }],
           valueField:'id',
           textField:'text'
       });
   })
</script>
<body style="margin: 0;background: #f4f4f4">
<div id="defect_select-tb">
    <div class="defect_select_search">
        <div>
            <span style="display: inline-block;width: 33%">
                <label>线路编号</label>
                <select type="text" style="width: 200px" id="line_code_select"></select>
            </span>
            <span style="display: inline-block;width: 33%">
                <label>缺陷类型</label>
                <select id="defect_type_select" class="easyui-combobox"  style="width: 200px"></select>
            </span>
            <span style="display: inline-block;width: 33%">
                <label>缺陷级别</label>
                <select id="defect_grade_select" class="easyui-combobox"  style="width: 200px"></select>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchDefect">搜索</a>
            </span>

        </div>
    </div>
</div>
<table class="easyui-datagrid" id="defect_select_dg"
       data-options="toolbar:'#defect_select-tb',pagination:true,url:'/defects',method:'get',loadFilter:loadFilter,
       onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'task_code',width:150,align:'center'">任务编号</th>
        <th data-options="field:'line_code',width:150,align:'center'">线路编号</th>
        <th data-options="field:'pole_code',width:150,align:'center'">杆塔编号</th>
        <th data-options="field:'defect_gradeString',align:'center'">缺陷级别</th>
        <th data-options="field:'defect_type_string',width:150,align:'center'">缺陷类型</th>
        <th data-options="field:'find_user_name',align:'center'">发现人</th>
        <th data-options="field:'find_time',width:150,align:'center'">发现时间</th>
        <th data-options="field:'distribute_user',align:'center'">下发人</th>
        <th data-options="field:'distribute_time',width:150,align:'center'">下发时间</th>
        <th data-options="field:'rate',align:'center'">完好率</th>
        <th data-options="field:'defect_description',width:150,align:'center'">缺陷描述</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        var $defect_select_dg=$("#defect_select_dg");
        var pos=-1;
        //过滤datagrid信息进行展示
        function loadFilter(result) {
            if(result.code==200){
                return result.data;
            }else{
                return {};
            }
        }
        function onLoadSuccess() {
            if(pos!=-1){
                $defect_select_dg.datagrid("selectRow",pos);
            }
        }

        function searchDefect() {
            $defect_select_dg.datagrid({
                queryParams:{
                    line_id:$("#line_code_select").combobox("getValue"),
                    defect_type:$("#defect_type_select").combobox("getValue"),
                    defect_grade:$("#defect_grade_select").combobox("getValue"),
                }
            })
        }

    </script>

</body>
</html>
