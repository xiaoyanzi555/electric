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
<body style="margin: 0;background: #F4F4F4">
<div class="easyui-dialog" title="线路信息" id="lines_dialog" style="width:450px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]"></div>
<div id="lines-tb">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:delFunc">删除</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:stopFunc">启用/停用</a>
    <div class="lines_search" style="float: right">
        <label>线路编号</label>
        <input id="search_lines_by_line_code" name="line_code" style="width: 200px">
        <label>线路状态</label>
        <select id="search_lines_by_run_state" class="easyui-combobox" name="run_state" style="width: 200px"></select>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchLines">搜索</a>
    </div>
</div>
<table class="easyui-datagrid" id="lines_dg"
       data-options="toolbar:'#lines-tb',pagination:true,url:'/lines',method:'get',
       loadFilter:loadFilter,onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'line_code',width:150,align:'center'">线路编码</th>
        <th data-options="field:'line_name',width:150,align:'center'">线路名称</th>
        <th data-options="field:'start_pole',width:200,align:'center'">起始杆号</th>
        <th data-options="field:'end_pole',width:200,align:'center'">结束杆号</th>
        <th data-options="field:'tower_base',width:100,align:'center'">塔基数</th>
        <th data-options="field:'run_stateString',width:100,align:'center'">运行状态</th>
        <th data-options="field:'use_stateString',width:100,align:'center'">启用状态</th>
        <th data-options="field:'_operation',formatter:operaterLines,align:'center',width:200">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        $(function () {
            $("#search_lines_by_run_state").combobox({
                data:[{
                    "id":"",
                    "text":"---请选择---",
                    "selected":true
                },{
                    "id":1,
                    "text":"正常"
                },{
                    "id":2,
                    "text":"检修中"
                }],
                valueField:'id',
                textField:'text'
            });
        })
    </script>
    <script type="text/javascript">
        var $lines_dd=$("#lines_dialog");
        var $lines_dg=$("#lines_dg");
        var pos=new Array();
        var renders={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/lines/edit.jsp");
        //过滤datagrid信息进行展示
        function loadFilter(result) {
            if(result.code==200){
                return result.data;
            }else{
                return {};
            }
        }
        function onLoadSuccess() {
            if(pos && pos.length>0){
                for(var i=0;i<pos.length;i++){
                    $lines_dg.datagrid("selectRow",pos[i]);
                }
                pos.length=0;//防止点击a标签修改让其加入了数组
            }
        }
        function addFunc() {
            $lines_dd.dialog({"href":"/page/lines/add.jsp"});
            $lines_dd.dialog("open");
        }
        function stopFunc(index) {
            pos.push(index);
            $lines_dg.datagrid("selectRow",index);
            var rows=$lines_dg.datagrid("getSelections");
            var ids="";
            if (rows && rows.length>0){
                $.messager.confirm("提示","你确定要停用/启用嘛？",function(r){
                    $.messager.progress();
                    if(r){
                        $.each(rows,function(i){
                            ids+=rows[i].id;
                            if(i<rows.length-1){
                                ids+=",";
                            }
                            pos.push($lines_dg.datagrid("getRowIndex",rows[i]));
                        });
                        $.ajax({
                            type:"put",
                            url:"/lines/"+ids,
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $lines_dg.datagrid("reload");
                                }else{
                                    $.messager.show({
                                        title:"错误",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                }
                            },
                            error:function(e){
                                $.messager.progress("close");
                                $.messager.show({
                                    title:"其他错误",
                                    msg:data.msg,
                                    showType:'slide'
                                })
                            }
                        })
                    }else {
                        $.messager.progress("close");
                    }
                })
            }else {
                $.messager.alert("警告","你还未选择目标")
            }

        }
        function editFunc(index) {
            pos.push(index);
            $lines_dg.datagrid("selectRow",index);
            var rows=$lines_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
                $.get("/lines/"+rows[0].id,function(result){
                    if(result.code==200){
                        $lines_dd.dialog({"href":"","content":renders.editRender(result.data)});
                        $lines_dd.dialog("open");
                    }
                })
                pos.push($lines_dg.datagrid("getRowIndex",rows[0]));
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }
        function delFunc(index) {
              $lines_dg.datagrid("selectRow",index);
                var rows=$lines_dg.datagrid("getSelections");
                var ids="";
                if (rows && rows.length>0){
                    $.messager.confirm("提示","你确定要删除嘛？",function(r){
                        $.messager.progress();
                        if(r){
                            $.each(rows,function(i){
                                ids+=rows[i].id;
                                if(i<rows.length-1){
                                    ids+=",";
                                }
                            });
                            $.ajax({
                                type:"delete",
                                url:"/lines/"+ids,
                                success:function(data){
                                    $.messager.progress("close");
                                    if(data.code==200){
                                        $.messager.show({
                                            title:"成功",
                                            msg:data.msg,
                                            showType:'slide'
                                        })
                                        $lines_dg.datagrid("reload");
                                    }else{
                                        $.messager.show({
                                            title:"错误",
                                            msg:data.msg,
                                            showType:'slide'
                                        })
                                    }
                                },
                                error:function(e){
                                    $.messager.progress("close");
                                    $.messager.show({
                                        title:"其他错误",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                }
                            })
                        }else {
                            $.messager.progress("close");
                        }
                    })
                }else {
                    $.messager.alert("警告","你还未选择目标")
                }

            }
        function saveDialog() {
            $("#lines_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#lines_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            var $lines_dataForm=$("#lines_dataForm");
            if(flag){
                $.ajax({
                    url:$lines_dataForm.attr("action"),
                    type:$lines_dataForm.attr("method"),
                    data:$lines_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $lines_dd.dialog("close");
                            $lines_dg.datagrid("reload");
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
            $lines_dd.dialog("close");
        }
        function operaterLines(val,row,index) {
            var value="";
            var style="";
            if (row.use_stateString=="启用"){
                value="停用";
                 style='style="color:#ccc"';
            }else{
                value="启用";
            }
            return '<a href="#" rel="nofollow"'+style+'onclick="stopFunc('+index+')">'+value+'</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
             '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                '<a href="#" rel="nofollow" onclick="delFunc('+index+')">删除</a>'
        }
        function searchLines(){
            $lines_dg.datagrid({
                queryParams:{
                    line_code:$("#search_lines_by_line_code").val(),
                    run_state:$("#search_lines_by_run_state").combobox("getValue")
                }
            })
        }
    </script>

</body>
</html>
