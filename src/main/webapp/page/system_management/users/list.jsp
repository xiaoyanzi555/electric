
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
<body style="margin: 0;background: #F4F4F4">
    <div class="easyui-dialog" title="用户信息" id="users_dialog" style="width:350px"
         data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]"></div>
    <div id="users-tb">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:delFunc">删除</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:stopFunc">冻结/启用</a>
        <div id="users_search">
            <label>用户名称</label>
            <input type="text" id="users_uname" name="uname">
            <label>使用状态</label>
            <select type="text" id="user_account_state" name="account_state" style="width: 200px"></select>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchUser">搜索</a>
        </div>
    </div>
    <table class="easyui-datagrid" id="users_dg"
           data-options="toolbar:'#users-tb',pagination:true,url:'/users',method:'get',
           loadFilter:loadFilter,onLoadSuccess:onLoadSuccess,rownumbers:true,striped:true">
        <thead>
            <tr>
                <th data-options="field:'account',width:150,align:'center'">用户账号</th>
                <th data-options="field:'uname',width:150,align:'center'">用户名称</th>
                <th data-options="field:'roleName',width:100,align:'center'">角色</th>
                <th data-options="field:'email',width:200,align:'center'">邮箱</th>
                <th data-options="field:'recent_login',width:200,align:'center'">最后登录时间</th>
                <th data-options="field:'account_stateString',width:200,align:'center'">状态(正常/冻结)</th>
                <th data-options="field:'_option',width:200,formatter:formatterOper,align:'center'">操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <script type="text/javascript">
        $("#user_account_state").combobox({
            data:[{
                "id":"",
                "text":"---请选择---",
                "selected":true
            },{
                "id":1,
                "text":"正常"
            },{
                "id":2,
                "text":"冻结"
            }],
            valueField:'id',
            textField:'text'
        });
    </script>
    <script type="text/javascript">
        var $users_dd=$("#users_dialog");
        var $users_dg=$("#users_dg");
        var pos=new Array();
        function formatterOper(val,row,index){
            var value=""
            if (row.account_stateString=="冻结"){
                value="启用";
            }else{
                value="冻结";
                var style='style="color:#999"'
            }
            return '<a href="#" rel="nofollow"'+style+' onclick="stopFunc('+index+')">'+value+'</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
             '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
             '<a href="#" rel="nofollow" onclick="delFunc('+index+')">删除</a>'

        }
        //渲染模板
        var renders={};
        function loadTpl(pageUrl) {
            $.get(pageUrl,function(html){
                renders['editRender']=template.compile(html);
            });
        }
        loadTpl("/page/system_management/users/edit.jsp");

        function loadFilter(result){
            if(result.code==200){
                return result.data;
            }else{
                return {"total":0};
            }
        }

        function addFunc() {
            $users_dd.dialog({"href":"/page/system_management/users/add.jsp"})
            $users_dd.dialog("open");
        }
        function delFunc(index){
            $users_dg.datagrid("selectRow",index);
            var rows=$users_dg.datagrid("getSelections");
            if(rows && rows.length>0){
                $.messager.confirm("警告","你确定要删除吗?",function(r){
                    $.messager.progress();
                    if(r){
                        var ids="";
                        $.each(rows,function(i){
                            ids+=rows[i].id+",";
                        });
                        $.ajax({
                            url:"/users/"+ids,
                            type:"delete",
                            data:null,
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $users_dd.dialog("close");
                                    $users_dg.datagrid("reload");
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
                        });
                    }else{
                        $.messager.progress("close");
                    }
                });
            }else{
                $.messager.alert("警告","未选中目标")
            }

        }
        function editFunc(index) {
            pos.push(index);
            $users_dg.datagrid("selectRow",index);
            var rows=$users_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行")
            }else if(rows.length==1){
                $.get("/users/"+rows[0].id,function(result){
                    if(result.code==200){
                        $users_dd.dialog({"href":"",content:renders.editRender(result.data)})
                        $users_dd.dialog("open");
                    }
                });
                pos.push($users_dg.datagrid("getRowIndex",rows[0]));
            }else{
                $.messager.alert("警告","未选择目标")
            }
        }
        function saveDialog() {
            $.messager.progress();
            $("#users_dataForm .easyui-validatebox").validatebox({"novalidate":false})
            var flag=true;
            $("#users_dataForm .easyui-validatebox").each(function() {
                if (!$(this).validatebox("isValid")) {
                    flag = false;
                    return false;

                }
            });
            var $users_dataForm=$("#users_dataForm");
            if(flag){
                $.ajax({
                    url:$users_dataForm.attr("action"),
                    type:$users_dataForm.attr("method"),
                    data:$users_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $users_dd.dialog("close");
                            $users_dg.datagrid("reload");
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
            $users_dd.dialog("close");
        }
        //加载成功
        function onLoadSuccess() {
            if(pos && pos.length>0){
                for(var i=0;i<pos.length;i++){
                    $users_dg.datagrid("selectRow",pos[i]);
                }
                pos.length=0;//防止点击a标签修改让其加入了数组
            }
        }
        function searchUser(){
            $users_dg.datagrid({"queryParams":{
                    account_state:$("#user_account_state").combobox("getValue"),
                    uname:$("#users_uname").val()
                }})
        }
        //批量冻结
        function stopFunc(index) {
            pos.push(index);
            $users_dg.datagrid("selectRow",index);
            var rows=$users_dg.datagrid("getSelections");
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
                            pos.push($users_dg.datagrid("getRowIndex",rows[i]));
                        });
                        $.ajax({
                            type:"put",
                            url:"/users/"+ids,
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $users_dg.datagrid("reload");
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
    </script>
</body>

</html>