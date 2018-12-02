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
</head>
<body style="margin: 0;background: #f4f4f4">
<div class="easyui-dialog" title="缺陷信息" id="defects_type_dialog" style="width:400px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]">
</div>
<div id="defects-tb">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:delFunc">删除</a>
</div>
<table class="easyui-datagrid" id="defects_type_dg"
       data-options="toolbar:'#defects-tb',pagination:true,url:'/defects_type',method:'get',
       loadFilter:loadFilter,onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'defect_type',width:550,align:'center'">缺陷名称</th>
        <th data-options="field:'use_state',checkbox:true,width:650,align:'center'">状态(启用/未启用)</th>
        <th data-options="field:'_operation',formatter:operaterLines,width:650,align:'center'">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<script type="text/javascript">
    $(function () {
       $("#state").datagrid({"checkbox":false})
    })
</script>
    <script type="text/javascript">
        var $defects_type_dd=$("#defects_type_dialog");
        var $defects_type_dg=$("#defects_type_dg");
        var pos=new Array();
        var renders={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/defects/defects_type/edit_defects_type.jsp");
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
                    $defects_type_dg.datagrid("selectRow",pos[i]);
                }
                pos.length=0;//防止点击a标签修改让其加入了数组
            }
        }
        function addFunc() {
            $defects_type_dd.dialog({"href":"/page/defects/defects_type/add_defects_type.jsp"});
            $defects_type_dd.dialog("open");
        }
        function editFunc(index) {
            pos.push(index);
            $defects_type_dg.datagrid("selectRow",index);
            var rows=$defects_type_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
                $.get("/defects_type/"+rows[0].id,function(result){
                    if(result.code==200){
                        $defects_type_dd.dialog({"href":"","content":renders.editRender(result.data)});
                        $defects_type_dd.dialog("open");
                    }
                })
                pos.push($defects_type_dg.datagrid("getRowIndex",rows[0]));
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }
        function delFunc(index) {
              $defects_type_dg.datagrid("selectRow",index);
                var rows=$defects_type_dg.datagrid("getSelections");
                var ids="";
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
                            url:"/defects_type/"+ids,
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $defects_type_dg.datagrid("reload");
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
            }
        function saveDialog() {
            $("#defects_type_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#defects_type_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            var defects_type_dataForm=$("#defects_type_dataForm");
            if(flag){
                $.ajax({
                    url:defects_type_dataForm.attr("action"),
                    type:defects_type_dataForm.attr("method"),
                    data:defects_type_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $defects_type_dd.dialog("close");
                            $defects_type_dg.datagrid("reload");
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
            $defects_type_dd.dialog("close");
        }
        function operaterLines(val,row,index) {
            return '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                '<a href="#" rel="nofollow" onclick="delFunc('+index+')">删除</a>'
        }
        function searchLines(){
            /*$defects_type_dg.datagrid({
                queryParams:{
                    line_code:$("#search_defects_by_line_code").val(),
                    run_state:$("#search_defects_by_run_state").combobox("getValue")
                }
            })*/
        }
    </script>

</body>
</html>
