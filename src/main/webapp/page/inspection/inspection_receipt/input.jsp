<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="input_tpl" style="background: #fff;width: 900px;overflow: hidden">
    <div style="width: 200px;border: 1px solid #666;height: auto;float: left">
        <p style="text-align: center"><strong>线路名称:{{pole[0].line_name}}</strong></p>
        <div style="margin-left: 70px">
            {{each pole}}
            <p class="code" data-id="{{$value.id}}">编号{{$value.pole_code}}</p>
            {{/each}}
        </div>
    </div>
    <div style="float: left">
        <img src="/static/imgs/arrow.jpg" style="margin-top: 150px">
    </div>
    <div style="float: left;width: 600px;border: 1px solid #666;height: auto;padding-left: 30px;">
        <p>
            <label style="width: 100px;display: inline-block">线路编号：</label>{{pole[0].line_code}}
        </p>
        <p>
            <label style="width: 100px;display: inline-block">杆塔编号：</label>
            <label id="input_pole_code">{{pole[0].pole_code}}</label>
        </p>
        <p>
            <label style="width: 100px;;display: inline-block;">缺陷类型：</label>
            <select id="input_defect_type" style="width: 200px;height: 28px"></select>
        </p>
        <p>
            <label style="width: 100px;height: 28px;display: inline-block">缺陷级别：</label>
            <select style="width: 200px;height: 28px" class="easyui-combobox" id="input_defect_grade"></select>
        </p>
        <p>
            <label style="width: 100px;display: inline-block">完好率：</label>
            <input style="width: 200px;height: 28px" id="input_rate" placeholder="请以百分号结尾">
        </p>
        <p>
            <label style="width: 100px;display: inline-block">发现时间：</label>
            <label style="width: 200px" id="current_time"></label>
        </p>
        <p>
            <label style="width: 100px;display: inline-block">发现人员：</label>
            <label id="find_people">${user.uname}</label>
        </p>
        <p>
            <label style="width: 100px;display: inline-block">缺陷描述：</label>
            <textarea style="width: 200px" cols="5" rows="5" id="input_discripe"></textarea>
        </p>
    </div>
    <div style="width: 400px;margin-top: 20px;float: right">
        <div style="color: red">用户必须先点击保存才可进行回执的提交</div>
        <button style="padding: 5px 8px" onclick="upload()">上传回执</button>
        <button style="padding: 5px 8px;margin-left: 30px" onclick="save()">保存</button>
        <button style="padding: 5px 8px;margin-left: 30px" onclick="back()">返回</button>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        loadEveryTime();
    })
    var indexColor=-1;//用于判断哪一个杆号被点击保存了
    $("#input_defect_grade").combobox({
        data:[{
            "id":-1,
            "text":"---请选择---",
            "selected":true
        },{
            "id":1,
            "text":"一般"
        },{
            "id":2,
            "text":"紧急"
        },{
            "id":3,
            "text":"严重"
        }],
        valueField:'id',
        textField:'text'
    })
    function back(){
        $.messager.confirm("警告","确定要返回吗？",function (r) {
            if(r){
                $("#input_tpl").hide();//移除当前页面显示datagrid
                //上传回执之后应该返回原界面
                $inspection_receipt_dg.datagrid("reload");
                $(".datagrid").show()
            }
        })

    }
    //构建一个大对象，里面存放对象信息
    var poles_all={};
    function save() {
        //点击一次保存构建一个对象
        var pole={};
        //默认对象的一些属性
        pole['line_id']="{{pole[0].line_id}}";
        pole['task_id']="{{pole[0].task_id}}";
        pole['find_time']=$("#current_time").html();
        pole['find_user_id']=${user.id};
        pole['pole_code']=$("#input_pole_code").html();
        pole['defect_type']=$("#input_defect_type").combobox("getValue");
        pole['defect_grade']=$("#input_defect_grade").combobox("getValue");
        pole['rate']=$("#input_rate").val();
        pole['defect_description']=$("#input_discripe").val();
        //获得poleid
        //找到点中的标签
        var pole_id=$(".code:eq("+indexColor+")")[0].dataset.id;
        pole['pole_id']=pole_id;
        poles_all[$("#input_pole_code").html()]=pole;//通过杆塔的编号作为唯一主键进行区分
        clearData();
        //点击完保存之后将该杆塔的编号设置为红色
        if(indexColor!=-1){
            $(".code:eq("+indexColor+")").css("color","red");
        }
    }
    function upload() {
        $.messager.confirm("警告","确定要提交吗？",function (r) {
            if (r) {
                //在构建一个对象只要里面的数据即可
                $.each(poles_all,function (i) {
                    //取出里面的对象，循环发送请求
                    $.ajax({
                        type:'put',
                        url:'/defects',
                        data:poles_all[i],
                        success:function(data){
                            $.messager.progress("close");
                            if(data.code==200){
                                $.messager.show({
                                    title:"成功",
                                    msg:data.msg,
                                    showType:'slide'
                                })

                                //如果上传成功，那么将该行的颜色改为黑色
                                $inspection_receipt_dg.datagrid({
                                    rowStyler: function(index,row){
                                        if(index==pos){
                                            return 'color:#000;';
                                        }

                                    }
                                });
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
                })
                //上传回执成功之后应该把录入界面删除
                $("#input_tpl").remove();//移除当前页面显示datagrid
                //上传回执之后应该返回原界面
                $inspection_receipt_dg.datagrid("reload");
                $(".datagrid").show()
            }
        })
    }
    function clearData() {
        //点击完保存之后对数据进行情空为下一次做好准备
        $("#input_discripe").val("");
        $("#input_rate").val("");
        $("#input_defect_type").combobox("select","")
        $("#input_defect_grade").combobox("select",-1)
    }

    //判断百分数
    $("#input_rate").blur(function () {
        var regex=/%$/;
        if(!regex.test($("#input_rate").val())){
            $("#input_rate").val("");
            $("#input_rate").focus();
        }
    });

    function loadEveryTime() {
        //查询所有缺陷类型
        $.ajax({
            type:'get',
            url:'/defects_type',
            headers:{"select":"find_all"},
            success:function (result) {
                if(result.code==200){
                    $("#input_defect_type").combobox({
                        data:result.data,
                        valueField:"id",
                        textField:"text"
                    })
                }
            }
        })
        //计算当前时间
        var current_time=getDate();
        $("#current_time").html(current_time);

        //给所有的code标签注册点击事件
        $(".code").click(function () {
            //在点击之前把所有的蓝色线清空
            $(".code").each(function () {
                if($(this).css('color')=='rgb(0, 0, 255)'){
                    $(this).css('color','#000');
                }
            })
            //点击的时候让他变为蓝色
            $(this).css("color","rgb(0,0,255)");
            var self=this;
            clearData();//防止没有保存也点击了其它编号没有清空数据
            //回显数据
            //循环大对象
            $.each(poles_all,function (i) {
                //如果该编号名称在大对象里面有那么就显示内容，否则不显示
                if($(self).html().substring(2)==poles_all[i]['pole_code']){
                    $("#input_pole_code").html(poles_all[i]['pole_code']);
                    $("#input_defect_type").combobox("select",poles_all[i]['defect_type']);
                    $("#input_defect_grade").combobox("select",poles_all[i]['defect_grade']);
                    $("#input_rate").val(poles_all[i]['rate']);
                    $("#input_discripe").val(poles_all[i]['defect_description']);
                }
            })
            //右边的杆塔编号会跟随着改变
            $("#input_pole_code").html($(this).html().substring(2))
            indexColor=$(this).index();
        });
    }
</script>