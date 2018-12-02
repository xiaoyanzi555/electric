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
<div id="inspection_receipt-tb">
    <div class="inspection_receipt_search">
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
           <span style="float: left;width: 33%;">
               <label>下 发 人</label>
               <select type="text" style="width: 200px" id="user_id"></select>
           </span>
           <span>
               <label>下发时间</label>
               <input type="text" class="easyui-datebox" id="time">
           </span>
           <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true,onClick:searchInspection">搜索</a>
       </div>
    </div>
</div>
<table class="easyui-datagrid" id="inspection_receipt_dg"
       data-options="toolbar:'#inspection_receipt-tb',pagination:true,url:'/inspectionReceipt',method:'get',loadFilter:loadFilter,
       onLoadSuccess:onLoadSuccess,striped:true,rownumbers:true">
    <thead>
    <tr>
        <th data-options="field:'task_code',width:150,align:'center'">任务编号</th>
        <th data-options="field:'task_name',width:150,align:'center'">任务名称</th>
        <th data-options="field:'line_name_String',width:150,align:'center'">巡检线路</th>
        <th data-options="field:'start_pole_code',width:130,align:'center'">起始杆号</th>
        <th data-options="field:'end_pole_code',width:130,align:'center'">终止杆号</th>
        <th data-options="field:'distribute_name',align:'center'">下发人</th>
        <th data-options="field:'distribute_time',width:150,align:'center'">下发时间</th>
        <th data-options="field:'task_State_String',styler:changeColor,align:'center'">任务状态</th>
        <th data-options="field:'task_end_time',width:150,align:'center'">任务完成时间</th>
        <th data-options="field:'_operation',formatter:operaterReceipt,width:150,align:'center'">操作</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <script type="text/javascript">
        var $inspection_receipt_dd=$("#inspection_receipt_dialog");
        var $inspection_receipt_dg=$("#inspection_receipt_dg");
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
        loadTpl("/page/inspection/inspection_receipt/input.jsp");//加载回执的模板
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
                $inspection_receipt_dg.datagrid("selectRow",pos);
            }
        }

        function operaterReceipt(val,row,index){
            var style='style=color:#ccc';
            //1:待分配，2：已分配，3：执行中，4：已完成
            if(row.task_state==2){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="inputFunc('+index+')" '+style+'>回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="exeFunc('+index+')">执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'">修改</a>'
            }else if(row.task_state==3){
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="inputFunc('+index+')">回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow"'+style+'>执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="editFunc('+index+')">修改</a>'
            }else {
                return '<a href="#" rel="nofollow" onclick="lookFunc('+index+')">查看</a>&nbsp;'+
                    '<a href="#" rel="nofollow" onclick="inputFunc('+index+')"'+style+'>回执录入</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>执行</a>&nbsp;'+
                    '<a href="#" rel="nofollow" '+style+'>修改</a>'
            }

        }
        //查看
        var datas={};//将模板数据存储到外部
        function lookFunc(index) {
            $inspection_receipt_dg.datagrid("selectRow",index);
            var rows=$inspection_receipt_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.progress("close");
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


        var colorIndex=-1;//记录一下改变行颜色的索引
        function inputFunc(index) {
            if($("#input_tpl").length>0){
                //表示还有为完成的回执信息
                $.messager.alert("提示","你还有为录入完的回执信息，请上传在录入其他的信息");
                //选中为录入的那一行信息
                $inspection_receipt_dg.datagrid({
                   rowStyler: function(index,row){
                       if(index==pos){
                           return 'color:red;';
                       }
                   }
                });
                return; //阻止往下执行
            }
            $inspection_receipt_dg.datagrid("selectRow",index);
            var rows=$inspection_receipt_dg.datagrid("getSelections");
            if(rows.length>1){
                $.messager.alert("警告","不能同时选中多行");
            }else if(rows.length==1){
                $.ajax({
                    url:'/poles',
                    type:'get',
                    data:{line_id:rows[0].line_id,task_id:rows[0].id},
                    headers:{"select":"lines_all_poles"},
                    success:function (result) {
                        console.log(result.data)
                        if(result.code==200){
                            //渲染模板
                            var poles={"pole":result.data}
                            var recipt=renders.editRender(poles)
                            //在点击绘制录入的时候清空上一次隐藏的tpl
                            $("#input_tpl").remove();//否则不会再次加载
                            $('body').append(recipt);
                            $(".datagrid").hide();
                        }
                    },
                    error:function(jqXHR,textStatus,errorThrown){
                        console.log(jqXHR);
                        console.log(textStatus);
                        console.log(errorThrown);
                    }
                })
                pos=$inspection_receipt_dg.datagrid("getRowIndex",rows[0]);
            }else {
                $.messager.alert("提示","未选中目标");
            }
        }
        function exeFunc(index) {
            $.messager.confirm("提示","确定执行？",function (r) {
                if(r){
                    $.messager.progress();
                    pos=index;
                    $inspection_receipt_dg.datagrid("selectRow",index);
                    var rows=$inspection_receipt_dg.datagrid("getSelections");
                    if(rows.length>1){
                        $.messager.alert("警告","不能同时编辑多行");
                    }else if(rows.length==1){
                        //修改状态
                        $.ajax({
                            type:'put',
                            url:'/inspection',
                            data:{id:rows[0].id,task_state:3},//修改为执行中
                            success:function(data){
                                $.messager.progress("close");
                                if(data.code==200){
                                    $.messager.show({
                                        title:"成功",
                                        msg:data.msg,
                                        showType:'slide'
                                    })
                                    $inspection_receipt_dg.datagrid("reload");
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
                        pos=$inspection_receipt_dg.datagrid("getRowIndex",rows[0]);
                    }else {
                        $.messager.alert("提示","未选中目标");
                    }
                }
            })

        }
        function editFunc(index) {
            if($("#input_tpl").length==0){
                $.messager.alert("警告","你还没有录入回执信息，不能进行修改");
                return;
            }
            //隐藏当前页面，显示修改页面
            loadEveryTime();
            $(".datagrid").hide();
            $("#input_tpl").show();
        }

        function searchInspection() {
            $inspection_receipt_dg.datagrid({
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
           if(value=="已分配"){
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
