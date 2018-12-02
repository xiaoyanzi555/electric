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
       //发送请求绑定下发人
       $.ajax({
           type:'get',
           url:'/users',
           headers:{"data":"all"},
           success:function(result){
               if (result.code==200){
                   $("#user_id").combobox({
                       data:result.data,
                       valueField:"id",
                       textField:"text"
                   })
               }
           }
       })
       //绑定任务状态
       $("#task_state_select").combobox({
           data:[{
               "id":"",
               "text":"---请选择---",
               "selected":true
           },{
               "id":1,
               "text":"待分配"
           },{
               "id":2,
               "text":"已分配"
           },{
               "id":3,
               "text":"执行中"
           },{
               "id":4,
               "text":"已完成"
           }],
           valueField:'id',
           textField:'text'
       });
   })
</script>
<body style="margin: 0;background: #f4f4f4">
<div class="easyui-dialog" title="巡检信息" id="inspection_making_dialog" style="width:450px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:saveDialog},
            {text:'取消',handler:cancelDialog}]">
</div>
<%--为了小弹出框--%>
<div class="easyui-dialog" title="巡检信息" id="small_dialog" style="width:450px"
     data-options="closed:true,top:50,
         buttons:[
            {text:'保存',handler:smallSave},
            {text:'取消',handler:smallCancel}]">
</div>
<div id="inspection_making-tb">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true,onClick:addFunc">添加</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,onClick:editFunc">修改</a>
    <div class="inspection_making_search" style="height: 80px">
        <div>
            <p style="float: left;width: 33%">
                <label>任务编号</label>
                <select type="text" style="width: 200px;" id="task_code_select"></select>
            </p>
            <p style="float: left;width: 33%">
                <label>线路编号</label>
                <select type="text" style="width: 200px" id="line_code_select"></select>
            </p>
            <p style="float: left;width: 33%">
                <label>任务状态</label>
                <select id="task_state_select" class="easyui-combobox" name="use_state" style="width: 200px"></select>
            </p>
        </div>
       <div>
           <span style="width: 33%;display: inline-block">
               <label>下 发 人 </label>
               <select type="text" style="width: 200px" id="user_id"></select>
           </span>
           <span>
               <label>下发时间</label>
               <input type="text" class="easyui-datebox" style="width: 200px" id="time">
               <a href="#" class="easyui-linkbutton"
                  data-options="iconCls:'icon-search',plain:true,onClick:searchInspection">搜索</a>
           </span>

       </div>
    </div>
</div>
<table class="easyui-datagrid" id="inspection_making_dg"
       data-options="toolbar:'#inspection_making-tb',pagination:true,url:'/inspection',method:'get',loadFilter:loadFilter,
       onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'task_code',align:'center'">任务编号</th>
        <th data-options="field:'task_name',align:'center',width:150">任务名称</th>
        <th data-options="field:'line_name_String',align:'center',width:150">巡检线路</th>
        <th data-options="field:'start_pole_code',align:'center,width:150'">起始杆号</th>
        <th data-options="field:'end_pole_code',align:'center',width:150">终止杆号</th>
        <th data-options="field:'distribute_name',align:'center'">下发人</th>
        <th data-options="field:'distribute_time',align:'center'">下发时间</th>
        <th data-options="field:'task_State_String',styler:changeColor,align:'center'">任务状态</th>
        <th data-options="field:'task_end_time',align:'center'">任务完成时间</th>
        <th data-options="field:'task_Cancel_String',align:'center'">任务是否取消</th>
        <th data-options="field:'_operation',formatter:operaterInspection,align:'center',width:160">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        var $inspection_making_dd=$("#inspection_making_dialog");
        var $inspection_making_dg=$("#inspection_making_dg");
        var pos=-1;
        var renders={};
        var renders_recipt={};
        function loadTpl(pageUrl){
            $.get(pageUrl,function (html) {
                renders['editRender']=template.compile(html);
            })
        }
        function loadTpl_Receipt(pageUrl){
            $.get(pageUrl,function (html) {
                renders_recipt['editRender']=template.compile(html);
            })
        }
        loadTpl("/page/inspection/inspection_making/edit.jsp");
        loadTpl_Receipt("/page/inspection/inspection_receipt/look_all_detail.jsp");//加载查看的模板
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
                $inspection_making_dg.datagrid("selectRow",pos);
            }
        }
        function addFunc() {
            $inspection_making_dd.dialog({"href":"/page/inspection/inspection_making/add.jsp"});
            $inspection_making_dd.dialog("open");
        }
        function editFunc(index) {
            pos=index;
            $inspection_making_dg.datagrid("selectRow",index);
            var rows=$inspection_making_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1){
                $.get("/inspection/"+rows[0].id,function(result){
                    if(result.code==200){
                        $inspection_making_dd.dialog({"href":"","content":renders.editRender(result.data)});
                        $inspection_making_dd.dialog("open");
                    }
                })
                pos=$inspection_making_dg.datagrid("getRowIndex",rows[0]);
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }

        function saveDialog() {
            $("#inspection_making_dataForm .easyui-validatebox").validatebox({"novalidate":false});
            var flag=true;
            $("#inspection_making_dataForm .easyui-validatebox").each(function(){
                if(!$(this).validatebox("isValid")){
                    flag=false;
                    return false;
                }
            });
            var $inspection_making_dataForm=$("#inspection_making_dataForm");
            if(flag){
                $.ajax({
                    url:$inspection_making_dataForm.attr("action"),
                    type:$inspection_making_dataForm.attr("method"),
                    data:$inspection_making_dataForm.serialize(),
                    success:function(data){
                        $.messager.progress("close");
                        if(data.code==200){
                            $.messager.show({
                                title:"成功",
                                msg:data.msg,
                                showType:'slide'
                            })
                            $inspection_making_dd.dialog("close");
                            $inspection_making_dg.datagrid("reload");
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
            dis_cl_save();//把子窗口也关闭
            $inspection_making_dd.dialog("close");
        }
        function operaterInspection(val,row,index){
            var style='style=color:#ccc';
            //1:待分配，2：已分配，3：执行中，4：已完成
            if(row.task_state==2 || row.task_cancel==1){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>修改</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="cancelFunc('+index+')">取消</a>'
            }else if(row.task_state==3 || row.task_state==4){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>修改</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>取消</a>'
            }else{
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="distributFunc('+index+')">分配任务</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>&nbsp;'+
                    '<a href="#" rel="nofollow"  onclick="cancelFunc('+index+')">取消</a>'
            }

        }
        var datas={};//将模板数据存储到外部
        function lookFunc(index) {
            $inspection_making_dg.datagrid("selectRow",index);
            var rows=$inspection_making_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时查看多行");
            }else if(rows.length==1) {
                //查询信息
                $.ajax({
                    url:'/inspectionReceipt',
                    type:'get',
                    headers:{"select":"all_detail"},
                    data:{line_id:rows[0].line_id,id:rows[0].id},
                    success: function (result) {
                        if (result.code == 200) {
                            //打开模板页面进行查看
                            datas['insb']=[result.data.dbInspection];
                            datas['pole_list']=result.data.pole_list;
                            datas['user_list']=result.data.user_list;
                            console.log(datas)
                            var html=renders_recipt.editRender(datas)
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
        var task_id="";//为了给后面弹框使用，因为获取不到
        var task_code="";//为了共用方法而空值会报错
        function distributFunc(index) {
            $inspection_making_dg.datagrid("selectRow",index);
            var rows=$inspection_making_dg.datagrid("getSelections");
            if(rows.length>1) {
                $.messager.alert("警告", "不能同时编辑多行");
                return;
             }
            if (rows.length==0){
                $.messager.alert("提示","未选中目标");
                return;
            }
            task_id=rows[0].id;
            pos=$inspection_making_dg.datagrid("getRowIndex",rows[0]);
            //打开一个选中的页面，让他在这个页面进行数据的选中
            $("#small_dialog").dialog({"href":"/page/inspection/inspection_making/distribution_check.jsp"});
            $("#small_dialog").dialog("open");
        }
        function smallSave() {
            var rows=$inspection_making_dg.datagrid("getSelections");
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
                url:'/inspection',
                data:{staff_ids:peopleid.join(","),id:task_id,task_state:2},
                success:function(data){
                    $.messager.progress("close");
                    if(data.code==200){
                        $.messager.show({
                            title:"成功",
                            msg:data.msg,
                            showType:'slide'
                        })
                        $("#small_dialog").dialog("close");
                        $inspection_making_dg.datagrid("reload");
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
        //取消任务
        function cancelFunc(index) {
            $.messager.progress();
            pos=index;
            $inspection_making_dg.datagrid("selectRow",index);
            var rows=$inspection_making_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.progress("close");
                $.messager.alert("警告","不能同时编辑多行");
            }else if(rows.length==1) {
                $.messager.confirm("提示", "确定要取消任务吗？", function (r) {
                    if (r) {
                        //修改状态
                        $.ajax({
                            type: 'put',
                            url: '/inspection',
                            data: {id: rows[0].id, task_cancel: 1},//修改取消
                            success: function (data) {
                                $.messager.progress("close");
                                if (data.code == 200) {
                                    $.messager.show({
                                        title: "成功",
                                        msg: data.msg,
                                        showType: 'slide'
                                    })
                                    $inspection_making_dg.datagrid("reload");
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
                        pos = $inspection_making_dg.datagrid("getRowIndex", rows[0]);
                    } else {
                        $.messager.alert("提示", "未选中目标");
                    }
                })
            }
        }

        function searchInspection() {
            $inspection_making_dg.datagrid({
                queryParams:{
                    task_code:$("#task_code_select").combobox("getValue"),
                    line_id:$("#line_code_select").combobox("getValue"),
                    task_state:$("#task_state_select").combobox("getValue"),
                    distribute_id:$("#user_id").combobox("getValue"),
                    distribute_time:$("#time").val()
                }
            })
        }
        function changeColor(value) {
            if(value=="待分配"){
                return "color:#FF9900"
            }else if(value=="已分配"){
                return "color:#0033FF"
            }else if(value=="执行中"){
                return "color:#FF33CC"
            }else{
                return "color:#009900"
            }

        }
    </script>
</body>
</html>
