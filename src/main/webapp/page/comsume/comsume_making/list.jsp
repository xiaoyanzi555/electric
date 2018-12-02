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
</head>
<body style="margin: 0;background: #f4f4f4">
<%--为了小弹出框--%>
<div class="easyui-dialog" title="消缺人员信息" id="small_dialog" style="width:450px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:smallSave},
            {text:'取消',handler:smallCancel}]">
</div>
        <div id="comsume-tb">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
            </div>
        </div>
        <table class="easyui-datagrid" id="comsume_dg"
               data-options="toolbar:'#comsume-tb',pagination:true,url:'/consumeTask',method:'get',loadFilter:loadFilter,
               onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
            <thead>
            <tr>
                <th data-options="field:'consume_task_code',width:150,align:'center'">任务编号</th>
                <th data-options="field:'task_name',width:150,align:'center'">任务名称</th>
                <th data-options="field:'work_documents_String',width:150,align:'center'">工作单据</th>
                <th data-options="field:'distribution_name',width:150,align:'center'">下发人</th>
                <th data-options="field:'distribute_time',width:150,align:'center'">下发时间</th>
                <th data-options="field:'task_State_String',styler:changeColor,align:'center'">任务状态</th>
                <th data-options="field:'task_complete_time',width:150,align:'center'">任务完成时间</th>
                <th data-options="field:'task_Cancel_String',width:150,align:'center'">任务是否取消</th>
                <th data-options="field:'_operation',formatter:operaterComsume">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    <script type="text/javascript">
        var $comsume_dg=$("#comsume_dg");
        var pos=-1;
        var renders={};
        var renders_edit={};
        var renders_look={};
        var renders_check={};
        //添加模板
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/comsume/comsume_making/add.jsp");
        //编辑模板
        function loadTpl_edite(pageUrl){
            $.get(pageUrl,function (html) {
                renders_edit['editRender']=template.compile(html);
            })
        }
        loadTpl_edite("/page/comsume/comsume_making/edit.jsp");
        function loadTpl_look(pageUrl){
            $.get(pageUrl,function (html) {
                renders_look['editRender']=template.compile(html);
            })
        }
        loadTpl_look("/page/comsume/comsume_making/look_detail.jsp");

        function loadTpl_check(pageUrl){
            $.get(pageUrl,function (html) {
                renders_check['editRender']=template.compile(html);
            })
        }
        loadTpl_check("/page/comsume/comsume_making/check.jsp");
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
                $comsume_dg.datagrid("selectRow",pos);
            }
        }
        function addFunc() {
            //加载模板
            var html=renders.editRender();
            $(".datagrid").hide();
            $("body").append(html);
        }
        function editFunc(index) {
            pos=index;
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
                $.get("/consumeTask/"+rows[0].id,function(result){
                    if(result.code==200){
                        //加载模板，显示数据
                        var html=renders_edit.editRender(result.data);
                        //隐藏datagrid
                        $(".datagrid").hide();
                        $("body").append(html);
                    }
                })
                pos=$comsume_dg.datagrid("getRowIndex",rows[0]);
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }
        function operaterComsume(val,row,index) {
            var style='style=color:#ccc';
            //1:待分配，2：已分配，3：执行中，4：已完成
            if(row.task_state==1){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="disFunc('+index+')">分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="cancelFunc('+index+')">取消</a>'
            }else if(row.task_state==2||row.task_state==3){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>修改</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>取消</a>'
            }else {
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="check('+index+')">审查</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>取消</a>'
            }
        }
        var task_id="";//为了给后面弹框使用，因为获取不到
        var task_code="";//为了共用方法而空值会报错
        function disFunc(index) {
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1) {
                $.messager.alert("警告", "不能同时编辑多行");
                return;
            }
            if (rows.length==0){
                $.messager.alert("提示","未选中目标");
                return;
            }
            task_id=rows[0].id;
            pos=$comsume_dg.datagrid("getRowIndex",rows[0]);
            //打开一个选中的页面，让他在这个页面进行数据的选中
            $("#small_dialog").dialog({"href":"/page/comsume/comsume_making/comsume_check.jsp"});
            $("#small_dialog").dialog("open");

        }
        function smallSave() {
            var rows=$comsume_dg.datagrid("getSelections");
            var peopleid=[];//人员id
            //点击保存之前首先情况值
            peopleid.length=0;
            //点击保存的时候获取被选中的值
            var options=$("#check_staf_check option");
            $.each(options,function (i) {
                peopleid.push($(this).val());
            })
            //发送ajax请求修改数据
            $.ajax({
                type:'put',
                url:'/consumeTask',
                data:{consomers:peopleid.join(","),id:task_id,task_state:2},
                success:function(data){
                    $.messager.progress("close");
                    if(data.code==200){
                        $.messager.show({
                            title:"成功",
                            msg:data.msg,
                            showType:'slide'
                        })
                        $("#small_dialog").dialog("close");
                        $comsume_dg.datagrid("reload");
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
        }
        function smallCancel() {
            $("#small_dialog").dialog("close");
        }
        function changeColor(value) {
            if(value=="已分配"){
                return "color:#0033FF";
            }else if(value=="执行中"){
                return "color:#FF33CC";
            }else if(value=='驳回'){
                return "color:red";
            }else{
                return "color:#009900"
            }

        }
        //取消任务
        function cancelFunc(index) {
            $.messager.progress();
            pos=index;
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.progress("close");
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1) {
                $.messager.confirm("提示", "确定要取消任务吗？", function (r) {
                    if (r) {
                        //修改状态
                        $.ajax({
                            type: 'put',
                            url: '/consumeTask',
                            data: {id: rows[0].id, task_cancel: 1},//取消
                            success: function (data) {
                                $.messager.progress("close");
                                if (data.code == 200) {
                                    $.messager.show({
                                        title: "成功",
                                        msg: data.msg,
                                        showType: 'slide'
                                    })
                                    $comsume_dg.datagrid("reload");
                                } else {
                                    $.messager.show({
                                        title: "错误",
                                        msg: data.msg,
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
                        pos = $comsume_dg.datagrid("getRowIndex", rows[0]);
                    } else {
                        $.messager.alert("提示", "未选中目标");
                    }
                })
            }
        }
        //查看

        function lookFunc(index) {
        //通过id查取出所有信息
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时查看多行");
            }else if(rows.length==1) {
                //查询信息
                $.ajax({
                    url:'/consumeTask/'+rows[0].id,
                    headers:{"select":"detail"},
                    type:'get',
                    success: function (result) {
                        if (result.code == 200) {
                            //打开模板页面进行查看
                            var html=renders_look.editRender(result.data);
                            $('body').append(html);
                            $(".datagrid").hide();
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
            } else {
                $.messager.alert("提示", "未选中目标");
            }
        }
        //审查
        function check(index) {
            //通过id查取出所有信息
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时查看多行");
            }else if(rows.length==1) {
                //查询信息
                $.ajax({
                    url:'/consumeTask/'+rows[0].id,
                    headers:{"select":"detail"},
                    type:'get',
                    success: function (result) {
                        if (result.code == 200) {
                            //打开模板页面进行查看
                            var html=renders_check.editRender(result.data);
                            $('body').append(html);
                            $(".datagrid").hide();
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
            } else {
                $.messager.alert("提示", "未选中目标");
            }
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
