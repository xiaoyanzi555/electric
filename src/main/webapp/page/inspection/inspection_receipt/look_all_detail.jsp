
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="lookTpl" style="margin-left: 200px;margin-top: 20px;background: #fff;width: 835px">
    <div style="width: 800px;border: 1px solid #262626;padding-left: 30px">
        <p>
            <span style="width: 250px;display: inline-block">
                <strong>任务编号：</strong>
                <label>{{insb[0].task_code}}</label>
            </span>
            <span style="width: 250px;display: inline-block">
                <strong>任务名称：</strong>
                <label>{{insb[0].task_name}}</label>
            </span>
            <span style="width: 250px;display: inline-block">
                <strong>巡检线路：</strong>
                <label>{{insb[0].line_name_String}}</label>
            </span>
        </p>
        <p>
            <span style="width: 250px;display: inline-block">
                <strong>起始杆号：</strong>
                <label>{{insb[0].start_pole_code}}</label>
            </span>
            <span style="width: 250px;display: inline-block">
                <strong>终止杆号：</strong>
                <label>{{insb[0].end_pole_code}}</label>
            </span>
            <span style="width: 250px;display: inline-block">
                <strong>下发人：</strong>
                <label>{{insb[0].distribute_name}}</label>
            </span>
        </p>
        <p>
            <span style="width: 350px;display: inline-block">
                <strong>下发时间：</strong>
                <label>{{insb[0].distribute_time}}</label>
            </span>
            <span style="width: 200px;display: inline-block">
                <strong>任务状态：</strong>
                <label>{{insb[0].task_State_String}}</label>
            </span>
        </p>
        <p>
            <span style="width: 350px;display: inline-block">
                <strong>任务完成时间：</strong>
                <label>{{insb[0].task_end_time}}</label>
            </span>
            <span style="width: 250px;display: inline-block">
                <strong>备注信息：</strong>
                <label>{{insb[0].remark}}</label>
            </span>
        </p>
        <p>
            <strong>巡检员：</strong>
            {{each user_list}}
            <label>{{$value.uname}}</label>
            {{/each}}
        </p>
    </div>
        <div style="margin-top:30px;overflow: hidden">
            <div style="width: 200px;height:500px;border: 1px solid #262626;float: left">
                <p style="text-align: center;width: 200px">
                    <strong>{{insb[0].line_name_String}}</strong>
                </p>
                <div style="width: 250px;text-align: center">
                    {{each pole_list}}
                    <p class="all_poles">{{$value.pole_code}}</p>
                    {{/each}}
                </div>
            </div>
            <div style="float: left;width: 70px;overflow: hidden">
                <img src="/static/imgs/arrow.jpg" style="margin-top: 150px">
            </div>
            <div style="width: 530px;border: 1px solid #262626;height:500px;float: left;padding-left: 30px">
                <div>
                    <p style="float: left;width: 50%">
                        <strong>线路编码：</strong>
                        <label>{{pole_list[0].line_code}}</label>
                    </p>
                    <p style="float: left;width: 50%">
                        <strong>杆塔编码：</strong>
                        <label id="receipt_pole_code">{{pole_list[0].pole_code}}</label><%--默认第一个--%>
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>有无故障：</strong>
                        <label id="is_defect">{{pole_list[0].defect.find_user_id==0?"无":"有"}}</label>
                    </p>
                    <p style="float: left;width: 50%">
                        <strong>完好率：</strong>
                        <label id="recepit_rate">{{pole_list[0].defect.rate}}</label>
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>缺陷类型：</strong>
                        <label id="recepit_defect_type">{{pole_list[0].defect.defect_type_string!==""?"无":pole_list[0].defect.defect_type_string}}</label>
                    </p>
                    <p style="float: left;width: 50%">
                        <strong>缺陷级别：</strong>
                        <label id="recepit_grade">{{pole_list[0].defect.defect_gradeString==""?"无":pole_list[0].defect.defect_gradeString}}</label>
                    </p>
                </div>

                <div>
                    <p>
                        <strong>缺陷描述：</strong>
                        <label id="recepit_des">{{pole_list[0].defect.defect_description==""?"无":pole_list[0].defect.defect_description}}</label>
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>巡检时间：</strong>
                        <label>{{insb[0].distribute_time}}</label>
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>巡检员：</strong>
                        {{each user_list}}
                        <label>{{$value.uname}}</label>
                        {{/each}}
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>缺陷发现人：</strong>
                        <label id="recepit_find_user_name">{{pole_list[0].defect.find_user_name==0?"暂无发现人":pole_list[0].defect.find_user_name}}</label>
                    </p>
                    <p style="float: left;width: 50%">
                        <strong>发现时间：</strong>
                        <label id="find_time">{{pole_list[0].defect.find_time}}</label>
                    </p>
                </div>

                <div>
                    <p style="float: left;width: 50%">
                        <strong>下发人员：</strong>
                        <label>{{insb[0].distribute_name}}</label>
                    </p>
                    <p style="float: left;width: 50%">
                        <strong>下发时间：</strong>
                        <label>{{insb[0].distribute_time}}</label>
                    </p>
                </div>
            </div>
        </div>
    <button style="float: right;padding: 5px 8px;margin-top: 20px" onclick="back_main()">返回</button>
</div>

<script type="text/javascript">
    var pos_pole=0;
    function back_main() {
        $.messager.confirm("警告","确定要返回吗？",function (r) {
            if(r){
                $("#lookTpl").remove();//移除当前页面显示datagrid
                //上传回执之后应该返回原界面
                $(".datagrid").show()
            }
        })
    }

    //默认第一个为红色
    $(".all_poles:eq(0)").css('color',"red");
    $(".all_poles").click(function () {
        //点击变成蓝色
        //点击之前清空所有的颜色
        $(".all_poles").css('color',"#000");
        $(this).css("color","red");
        //获得下标好动态改变所有的内容
        var index=$(this).index();
       //找到所有的控件进行点击改变数据
        $("#receipt_pole_code").html(datas.pole_list[index].pole_code);
        if( datas.pole_list[index].defect.find_user_id==0){
            $("#is_defect").html("无")
        }else{
            $("#is_defect").html("有")
        }
        $("#recepit_rate").html(datas.pole_list[index].defect.rate);
        //缺陷类型
        if((typeof($(datas.pole_list[index].defect).attr("defect_type_string"))=="undefined")){
            $("#recepit_defect_type").html("暂无");
        }else {
            $("#recepit_defect_type").html(datas.pole_list[index].defect.defect_type_string);
        }
        if (datas.pole_list[index].defect.defect_gradeString==""){
            $("#recepit_grade").html("无");
        }else{
            $("#recepit_grade").html(datas.pole_list[index].defect.defect_gradeString);
        }
        //如果存在就是自己，不存在就是10%
        if((typeof($(datas.pole_list[index].defect).attr("rate"))=="undefined")){
            $("#recepit_rate").html("暂无介绍");
        }else {
            $("#recepit_rate").html(datas.pole_list[index].defect.rate);
        }

        $("#recepit_des").html(datas.pole_list[index].defect.defect_description);
        if(datas.pole_list[index].defect.find_user_name==0){
            $("#recepit_find_user_name").html("暂无发现人");
        }else{
            $("#recepit_find_user_name").html(datas.pole_list[index].defect.find_user_name);
        }

        $("#find_time").html(datas.pole_list[index].defect.find_time);

});
</script>