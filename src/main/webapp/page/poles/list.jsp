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
    <script type="text/javascript" src="/static/js/find.js"></script>
    <script type="text/javascript">
        $(function () {
            find_poles_by_line_id();
            find_poles_by_use_state();
        })
    </script>
</head>
<body style="margin: 0;background: #F4F4F4">
<div class="easyui-dialog" title="杆塔信息" id="poles_dialog" style="width:350px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]"></div>
<div id="poles-tb">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:delFunc">删除</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:stopFunc">启用/停用</a>
    <div class="poles_search" style="float: right">
        <label>所属线路</label>
        <select id="search_poles_by_lines" class="easyui-combobox" name="line_id" style="width: 200px">

        </select>
        <label>是否启用</label>
        <select id="search_poles_by_use_state" class="easyui-combobox" name="use_state" style="width: 200px"></select>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchPoles">搜索</a>
    </div>
</div>
<table class="easyui-datagrid" id="poles_dg"
       data-options="toolbar:'#poles-tb',pagination:true,url:'/poles',method:'get',loadFilter:loadFilter,
       onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'pole_code',width:300,align:'center'">杆塔编号</th>
        <th data-options="field:'line_name',width:300,align:'center'">所属线路</th>
        <th data-options="field:'use_stateString',width:300,align:'center'">状态</th>
        <th data-options="field:'_operation',width:300,formatter:operaterPole,align:'center'">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        var $poles_dd=$("#poles_dialog");
        var $poles_dg=$("#poles_dg");
        var pos=new Array();
        var renders={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/poles/edit.jsp");
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
                    $poles_dg.datagrid("selectRow",pos[i]);
                }
                pos.length=0;//防止点击a标签修改让其加入了数组

            }
        }
        function addFunc() {
            $poles_dd.dialog({"href":"/page/poles/add.jsp"});
            $poles_dd.dialog("open");
        }
        function stopFunc(index) {
            pos.push(index);
            $poles_dg.datagrid("selectRow",index);
            var rows=$poles_dg.datagrid("getSelections");
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
                            pos.push($poles_dg.datagrid("getRowIndex",rows[i]));
                        });
                        $.ajax({
                            type:"put",
                            url:"/poles/"+ids,
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $poles_dg.datagrid("reload");
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
            $poles_dg.datagrid("selectRow",index);
            var rows=$poles_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
                $.get("/poles/"+rows[0].id,function(result){
                    if(result.code==200){
                        $poles_dd.dialog({"href":"","content":renders.editRender(result.data)});
                        $poles_dd.dialog("open");
                    }
                })
                pos.push($poles_dg.datagrid("getRowIndex",rows[0]));
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }
          function delFunc(index) {
              $poles_dg.datagrid("selectRow",index);
                var rows=$poles_dg.datagrid("getSelections");
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
                              url:"/poles/"+ids,
                              success:function(data){
                                  $.messager.progress("close");
                                  if(data.code==200){
                                      $.messager.show({
                                          title:"成功",
                                          msg:data.msg,
                                          showType:'slide'
                                      })
                                      $poles_dg.datagrid("reload");
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
            $("#poles_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#poles_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            var $poles_dataForm=$("#poles_dataForm");
            if(flag){
                $.ajax({
                    url:$poles_dataForm.attr("action"),
                    type:$poles_dataForm.attr("method"),
                    data:$poles_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $poles_dd.dialog("close");
                            $poles_dg.datagrid("reload");
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
            $poles_dd.dialog("close");
        }
        function operaterPole(val,row,index) {
            var value=""
            if (row.use_stateString=="启用"){
                value="停用";
                var style='style="color:#ccc"'
            }else{
                value="启用";
            }
            return '<a href="#" id="is_stop" rel="nofollow"'+style+' onclick="stopFunc('+index+')">'+value+'</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                 '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                '<a href="#" rel="nofollow" onclick="delFunc('+index+')">删除</a>'
        }
        function searchPoles(){
            $poles_dg.datagrid({
                queryParams:{
                    line_id:$("#search_poles_by_lines").combobox("getValue"),
                    use_state:$("#search_poles_by_use_state").combobox("getValue")
                }
            })
        }
    </script>
</body>
</html>
