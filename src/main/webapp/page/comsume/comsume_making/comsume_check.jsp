<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/12
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="float: left;margin-left: 40px">
    <p><label>待选择列表</label></p>
    <select multiple style="width: 150px;height: 200px" id="all_staff_check"></select>
</div>
<div style="float: left;margin-top: 100px">
    <span>
    <p><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:rightFunc">→</a></p>
    <p><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:leftFunc">←</a></p>
</span>
</div>
<div style="float: left;">
    <p><label>已经选择列表</label></p>
    <select multiple style="height: 200px;width: 150px" id="check_staf_check"></select>
</div>

<script type="text/javascript">
    $(function () {
        //通过角色表查询出巡检员的id
        $.ajax({
            type:'get',
            url:'/roles',
            data:{role_name:"消缺员"},
            headers:{"select":"ins"},
            success:function (result) {
                if(result.code==200){
                    var roleid=result.data.id;
                    //查取出所有的用户显示在列表中,且身份是巡检员的
                    //必须完成之后再发请求不然获取不到id
                    $.ajax({
                        url:"/roles/"+roleid+"/users",
                        data:{role_id:roleid},
                        success:function (result) {
                            if(result.code==200){
                                var allstf=result.data;
                                $.each(allstf,function(i){
                                    var child='<option value="'+allstf[i].id+'">'+allstf[i].text+'</option>'
                                    $("#all_staff_check").append(child);

                                })
                            }
                            //如果id存在则是修改页面，应该默认选中才对，通过任务的id查取出中间表人员的编号
                            //如果编号和所选的编号一致就让他在右边的栏目进行显示
                            //要在上一个ajax发送请求成功之后才能获取
                            var alluser=$("#all_staff_check option");
                            $.ajax({
                                type:'get',
                                url:'/users',
                                data:{task_id:task_id,pos_type:2},
                                headers:{"select":"uic"},
                                success:function (result) {
                                    if(result.code==200){
                                        var selectuser=result.data;
                                        console.log(selectuser)
                                        for(var i=0;i<alluser.length;i++){
                                            //循环json对象
                                            for(var j=0;j<selectuser.length;j++){
                                                var userid=selectuser[j].id; //i得到的是account
                                                if($("#all_staff_check option:eq("+i+")").val()==userid){
                                                    $("#check_staf_check")[0].appendChild($("#all_staff_check option:eq("+i+")")[0]);
                                                }
                                            }

                                        }
                                    }
                                }
                            })
                        }
                    })
                }
            }
        })

    })
    function rightFunc() {
        $("#all_staff_check option:selected").each(function () {
            $("#check_staf_check")[0].appendChild($(this)[0]);
        })
    }
    function leftFunc() {
        $("#check_staf_check option:selected").each(function () {
            $("#all_staff_check")[0].appendChild($(this)[0]);
        })
    }
</script>