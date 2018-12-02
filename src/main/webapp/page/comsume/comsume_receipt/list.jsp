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
<body style="margin: 0;background: #f4f4f4;">
        <table class="easyui-datagrid" id="comsume_dg"
               data-options="toolbar:'#comsume-tb',pagination:true,url:'/consumeReceipt',method:'get',loadFilter:loadFilter,
               onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
            <thead>
            <tr>
                <th data-options="field:'consume_task_code',align:'center',width:150">任务编号</th>
                <th data-options="field:'task_name',align:'center',width:150">任务名称</th>
                <th data-options="field:'work_documents_String',align:'center',width:150">工作单据</th>
                <th data-options="field:'distribution_name',align:'center',width:150">下发人</th>
                <th data-options="field:'distribute_time',align:'center',width:150">下发时间</th>
                <th data-options="field:'task_State_String',styler:changeColor,align:'center',width:150">任务状态</th>
                <th data-options="field:'task_complete_time',align:'center',width:150">任务完成时间</th>
                <th data-options="field:'_operation',formatter:operaterComsume,align:'center',width:180">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    <script type="text/javascript">
        var $comsume_dg=$("#comsume_dg");
        var pos=-1;
        var renders={};
        var renders_look={};
        var renders_check={};
        //添加模板
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/comsume/comsume_receipt/input.jsp");
        function loadTpl_look(pageUrl){
            $.get(pageUrl,function (html) {
                renders_look['editRender']=template.compile(html);
            })
        }
        loadTpl_look("/page/comsume/comsume_receipt/look_detail.jsp");

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

        function editFunc(index) {
            //其实修改和录入的方法调用是一样的
            inputRecipt(index);
        }
        //变为执行中
        function exeFunc(index) {
            $.messager.progress();
            pos=index;
            $comsume_dg.datagrid("selectRow",index);
            var rows=$comsume_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
               $.ajax({
                   url:'/consumeTask',
                   type:'put',
                   data:{id:rows[0].id,task_state:3},
                   success:function(data){
                       $.messager.progress("close");
                       if(data.code==200){
                           $.messager.show({
                               title:"成功",
                               msg:data.msg,
                               showType:'slide'
                           })
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
                       $.messager.progress("close");
                       $.messager.show({
                           title:"出错了",
                           msg:e,
                           showType:'slide'
                       })
                   }


               })
                pos=$comsume_dg.datagrid("getRowIndex",rows[0]);
            }else {
                $.messager.progress("close");
                $.messager.alert("提示","未选中目标");
            }
        }
        function inputRecipt(index) {
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
                            console.log(result.data)
                            console.log("3333")
                            var html=renders.editRender(result.data);
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
        function operaterComsume(val,row,index) {
            var style='style=color:#ccc';
            //1:待分配，2：已分配，3：执行中，4：已完成
            if(row.task_state==2){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="exeFunc('+index+')">执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>修改</a>'
            }else if(row.task_state==3){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="inputRecipt('+index+')">回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>'
            }else if(row.task_state==5) {
                return '<a href="#" rel="nofollow" onclick="lookFunc(' + index + ')">查看</a>&nbsp;' +
                    '<a href="#" rel="nofollow" '+ style +'>回执录入</a>&nbsp;' +
                    '<a href="#" rel="nofollow"' + style + '>执行</a>&nbsp;' +
                    '<a href="#" rel="nofollow" onclick="editFunc(' + index + ')">修改</a>'
            }
            else {
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="editFunc(' + index + ')">修改</a>'
            }
        }

        function changeColor(value) {
            if(value=="已分配"){
                return "color:#0033FF"
            }else if(value=="执行中"){
                return "color:#FF33CC"
            }else{
                return "color:#009900"
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
