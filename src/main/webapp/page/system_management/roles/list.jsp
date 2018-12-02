<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/5
  Time: 11:01
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
    <script type="text/javascript" src="/static/js/check.js"></script>
</head>
<body style="margin: 0;background: #F4F4F4">
    <div class="easyui-dialog" title="用户信息" id="roles_dialog" style="width:350px"
         data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]"></div>
    <div id="roles-tb">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:delFunc">删除</a>
        <div>
            <label>角色名称</label>
            <select type="text" name="role_name" id="roles_role_name" style="width: 200px"></select>
            <label>启用状态</label>
            <input type="text" name="use_state" id="roles_use_state">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchRole">搜索</a>
        </div>
    </div>
    <table class="easyui-datagrid" id="roles_dg"
           data-options="toolbar:'#roles-tb',pagination:true,url:'/roles',method:'get',loadFilter:loadFilter,
           onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
        <thead>
            <tr>
                <th data-options="field:'role_code',width:250,align:'center'">角色编号</th>
                <th data-options="field:'role_name',width:250,align:'center'">角色名称</th>
                <th data-options="field:'createByName',width:230,align:'center'">创建人</th>
                <th data-options="field:'modify_date',width:260,align:'center'">更新时间</th>
                <th data-options="field:'use_state',checkbox:true,width:200,align:'center'">状态（启用/未启用）</th>
                <th data-options="field:'_operation',width:200,formatter:operaterRole,align:'center'">操作</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <script type="text/javascript">
        $(function () {
            //查询出所有角色名称
            $.ajax({
                url:"/roles",
                type:"get",
                headers:{"select":"role_name"},
                success:function(result){
                    if (result.code==200){
                        $("#roles_role_name").combobox({
                            data:result.data,
                            valueField:'id',
                            textField:'text'
                        })
                    }
                }
            })
            $("#roles_use_state").combobox({
                data:[{
                    "id":"",
                    "text":"---请选择---",
                    "selected":true
                },{
                    "id":1,
                    "text":"启用"
                },{
                    "id":2,
                    "text":"未启用"
                }],
                valueField:'id',
                textField:'text'
            });
        })
    </script>
    <script type="text/javascript">
        var $roles_dd=$("#roles_dialog");
        var $roles_dg=$("#roles_dg");
        var pos=new Array();
        function operaterRole(val,row,index) {
              return '<a href="#" rel="nofollow" onclick="editFunc('+index+')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
                '<a href="#" rel="nofollow" onclick="delFunc('+index+')">删除</a>'
        }
        function loadFilter(result){
            if(result.code==200){
                return result.data;
            }else{
                return {"total":0};
            }
        }
        //远程加载数据
        var renders={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function(html){
                renders['editRender']=template.compile(html);
            });
        }
        loadTpl("/page/system_management/roles/edit.jsp");
        function addFunc() {
            $roles_dd.dialog({"href":"/page/system_management/roles/add.jsp"})
            $roles_dd.dialog("open");
        }
        function editFunc(index) {
            pos.push(index);
            $roles_dg.datagrid("selectRow",index);
            var rows=$roles_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行")
            }else if(rows.length==1){
                $.get("/roles/"+rows[0].id,function(result){
                   if(result.code==200){
                       $roles_dd.dialog({"href":"","content":renders.editRender(result.data)})
                       $roles_dd.dialog("open");
                   }
                });
                pos.push($roles_dg.datagrid("getRowIndex",rows[0]));
            }else{
                $.messager.alert("警告","未选择目标")
            }

        }
        //删除
        function delFunc(index){
            $roles_dg.datagrid("selectRow",index);
            var rows=$roles_dg.datagrid("getSelections");
            var ids="";
            if (rows && rows.length>0){
                $.messager.confirm("确认","你确定要删除吗？",function(r){
                    if(r){
                        $.messager.progress();
                        $.each(rows,function(i){
                            ids+=rows[i].id;
                            if(i<rows.length-1){
                                ids+=",";//这里去除逗号主要是为了最后一个害怕无条件把所有的都删除了
                            }
                        })
                        $.ajax({    //roles/1,2,3
                            url:"/roles/"+ids,
                            data:null,
                            type:"delete",
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $roles_dg.datagrid("reload");
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
                    }
                })
            }else {
                $.messager.alert("警告","你还未选择目标")
            }

        }
        function saveDialog() {
            $.messager.progress();
            $("#roles_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#roles_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            if(flag){
                var $roles_form=$("#roles_dataForm");
                $.ajax({
                    url:$roles_form.attr("action"),
                    data:$roles_form.serialize(),
                    type:$roles_form.attr("method"),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $roles_dd.dialog("close");
                            $roles_dg.datagrid("reload");
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
                });
            }else {
                $.messager.progress("close");
            }
        }
        function cancelDialog() {
            $roles_dd.dialog("close");
        }
        function onLoadSuccess() {
            if(pos && pos.length>0){
                for(var i=0;i<pos.length;i++){
                    $roles_dg.datagrid("selectRow",pos[i]);
                }
                pos.length=0;//防止点击a标签修改让其加入了数组
            }
        }
        function searchRole(){
            $roles_dg.datagrid({
                queryParams:{
                    role_name:$("#roles_role_name").combobox("getValue"),
                    use_state:$("#roles_use_state").combobox("getValue")
                }
            })
        }
    </script>
</body>

</html>
